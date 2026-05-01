local settings = require("core.settings")
local system = require("utils.system")

local lsp_state = { progress = "" }
local lsp_spinners = { "", "󰪞", "󰪟", "󰪠", "󰪡", "󰪢", "󰪣", "󰪤", "󰪥", "", "" }

vim.api.nvim_create_autocmd("LspProgress", {
  group = vim.api.nvim_create_augroup("LualineLspProgress", { clear = true }),
  pattern = { "begin", "report", "end" },
  callback = function(args)
    local data = args.data and args.data.params and args.data.params.value
    if not data then
      return
    end

    if data.kind == "end" then
      lsp_state.progress = ""
    else
      local pct = data.percentage or 0
      local idx = 1 + ((pct - pct % 10) / 10)
      local spinner = lsp_spinners[idx] or lsp_spinners[#lsp_spinners]
      local progress = ""

      if data.message then
        local start_pos, stop_pos = data.message:find("^%d+/%d+")
        if start_pos then
          progress = data.message:sub(start_pos, stop_pos)
        end
      end

      lsp_state.progress = spinner
          .. " "
          .. tostring(pct)
          .. "%% "
          .. (data.title or "")
          .. (progress ~= "" and " " .. progress or "")
    end

    pcall(vim.cmd.redrawstatus)
  end,
})

local icons = {
  aichat = {
    Copilot = "",
  },
  diagnostics = {
    Error = "",
    Warning = "",
    Information = "",
    Hint = "󰌶",
  },
  git = {
    Add = "",
    Branch = "",
    Mod = "",
    Remove = "",
  },
  misc = {
    LspAvailable = "󱜙",
    NoActiveLsp = "󱚧",
    PyEnv = "󰢩",
  },
  ui = {
    FolderWithHeart = "󱃪",
    Tab = "",
  },
}

local function has_catppuccin()
  return type(vim.g.colors_name) == "string" and vim.g.colors_name:find("catppuccin") ~= nil
end

local function get_palette()
  local ok, palettes = pcall(require, "catppuccin.palettes")
  if not ok then
    return nil
  end
  return palettes.get_palette(settings.colorscheme_flavour)
end

local function custom_theme()
  if not has_catppuccin() then
    return "auto"
  end

  local colors = get_palette()
  if not colors then
    return "auto"
  end

  local universal_bg = settings.transparent_background and "NONE" or colors.mantle
  return {
    normal = {
      a = { fg = colors.lavender, bg = colors.surface0, gui = "bold" },
      b = { fg = colors.text, bg = universal_bg },
      c = { fg = colors.text, bg = universal_bg },
    },
    command = {
      a = { fg = colors.peach, bg = colors.surface0, gui = "bold" },
    },
    insert = {
      a = { fg = colors.green, bg = colors.surface0, gui = "bold" },
    },
    visual = {
      a = { fg = colors.flamingo, bg = colors.surface0, gui = "bold" },
    },
    terminal = {
      a = { fg = colors.teal, bg = colors.surface0, gui = "bold" },
    },
    replace = {
      a = { fg = colors.red, bg = colors.surface0, gui = "bold" },
    },
    inactive = {
      a = { fg = colors.subtext0, bg = universal_bg, gui = "bold" },
      b = { fg = colors.subtext0, bg = universal_bg },
      c = { fg = colors.subtext0, bg = universal_bg },
    },
  }
end

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("LualineColorScheme", { clear = true }),
  pattern = "*",
  callback = function()
    local ok, lualine = pcall(require, "lualine")
    if ok then
      lualine.setup({ options = { theme = custom_theme() } })
    end
  end,
})

local function has_enough_room()
  return vim.o.columns > 100
end

local function has_filetype()
  return vim.bo.filetype ~= ""
end

local function has_git()
  local path = vim.fn.expand("%:p:h")
  if path == "" then
    return false
  end

  local gitdir = vim.fs.find(".git", {
    limit = 1,
    upward = true,
    type = "directory",
    path = path,
  })
  return #gitdir > 0
end

local function palette_hl(fg, bg, gui, transparent_bg)
  if not has_catppuccin() then
    return nil
  end

  return function()
    local colors = get_palette()
    if not colors then
      return {}
    end

    return {
      fg = colors[fg] or colors.none,
      bg = transparent_bg and settings.transparent_background and colors.none or (bg and colors[bg] or nil),
      gui = gui,
    }
  end
end

local function abbreviate_path(path)
  path = vim.fs.normalize(path)
  if path:find(system.home, 1, true) == 1 then
    return "~" .. path:sub(#system.home + 1)
  end
  return path
end

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local components = {}

components.separator = {
  function()
    return "│"
  end,
  padding = 0,
  color = palette_hl("surface1", nil, nil, true),
  separator = { left = "", right = "" },
}

components.file_status = {
  function()
    local function is_new_file()
      local filename = vim.fn.expand("%")
      return filename ~= "" and vim.bo.buftype == "" and vim.fn.filereadable(filename) == 0
    end

    local symbols = {}
    if vim.bo.modified then
      table.insert(symbols, "[+]")
    end
    if not vim.bo.modifiable then
      table.insert(symbols, "[-]")
    end
    if vim.bo.readonly then
      table.insert(symbols, "[RO]")
    end
    if is_new_file() then
      table.insert(symbols, "[New]")
    end

    return #symbols > 0 and table.concat(symbols, "") or ""
  end,
  padding = { left = -1, right = 1 },
  cond = has_filetype,
}

components.lsp = {
  function()
    local bufnr = vim.api.nvim_get_current_buf()
    local buf_ft = vim.bo.filetype
    local clients = vim.lsp.get_clients({ bufnr = bufnr })
    local seen = {}
    local names = {}

    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 and not seen[client.name] then
        seen[client.name] = true
        table.insert(names, client.name)
      end
    end

    if #names == 0 then
      return icons.misc.NoActiveLsp
    end

    return string.format("%s[%s] %s", icons.misc.LspAvailable, table.concat(names, ", "), lsp_state.progress)
  end,
  color = palette_hl("blue", nil, "bold", true),
  cond = has_enough_room,
}

components.chat_progress = {
  (function()
    local processing = false
    local animate_chars = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    local animation_idx = 1

    vim.api.nvim_create_autocmd("User", {
      pattern = { "CodeCompanionRequestStarted", "CodeCompanionRequestFinished" },
      group = vim.api.nvim_create_augroup("CodeCompanionHooks", { clear = true }),
      callback = function(args)
        processing = args.match == "CodeCompanionRequestStarted"
      end,
    })

    return function()
      if not processing then
        return ""
      end

      animation_idx = animation_idx % #animate_chars + 1
      return string.format("%s %s", icons.aichat.Copilot, animate_chars[animation_idx])
    end
  end)(),
  color = palette_hl("yellow", nil, nil, true),
  cond = has_enough_room,
}

components.python_venv = {
  function()
    local function env_cleanup(venv)
      return vim.fs.basename(venv) or venv
    end

    if vim.bo.filetype ~= "python" then
      return ""
    end

    local venv = vim.env.CONDA_DEFAULT_ENV or vim.env.VIRTUAL_ENV
    return venv and (icons.misc.PyEnv .. env_cleanup(venv)) or ""
  end,
  color = palette_hl("green", nil, nil, true),
  cond = has_enough_room,
}

components.tabwidth = {
  function()
    return icons.ui.Tab .. " " .. vim.bo.tabstop
  end,
  padding = 1,
}

components.cwd = {
  function()
    return icons.ui.FolderWithHeart .. " " .. abbreviate_path(vim.uv.cwd())
  end,
  color = palette_hl("subtext0", nil, "bold", true),
  cond = has_enough_room,
}

components.file_location = {
  function()
    local cursorline = vim.fn.line(".")
    local cursorcol = vim.fn.virtcol(".")
    local filelines = vim.fn.line("$")
    local position

    if cursorline == 1 then
      position = "Top"
    elseif cursorline == filelines then
      position = "Bot"
    else
      position = string.format("%2d%%%%", math.floor(cursorline / filelines * 100))
    end

    return string.format("%s · %3d:%-2d", position, cursorline, cursorcol)
  end,
}

return {
  options = {
    icons_enabled = true,
    theme = custom_theme(),
    disabled_filetypes = { statusline = { "alpha" } },
    component_separators = "",
    section_separators = { left = "", right = "" },
    globalstatus = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      {
        "filetype",
        colored = true,
        icon_only = false,
        icon = { align = "left" },
      },
      components.file_status,
      vim.tbl_extend("force", components.separator, {
        cond = function()
          return has_git() and has_filetype()
        end,
      }),
    },
    lualine_c = {
      {
        "branch",
        icon = icons.git.Branch,
        color = palette_hl("subtext0", nil, "bold", true),
        cond = has_git,
      },
      {
        "diff",
        symbols = {
          added = icons.git.Add,
          modified = icons.git.Mod,
          removed = icons.git.Remove,
        },
        source = diff_source,
        colored = false,
        color = palette_hl("subtext0", nil, nil, true),
        cond = has_git,
        padding = { right = 1 },
      },
      {
        function()
          return "%="
        end,
      },
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        sections = { "error", "warn", "info", "hint" },
        symbols = {
          error = icons.diagnostics.Error,
          warn = icons.diagnostics.Warning,
          info = icons.diagnostics.Information,
          hint = icons.diagnostics.Hint,
        },
      },
      components.lsp,
    },
    lualine_x = {
      components.chat_progress,
      {
        "encoding",
        show_bomb = true,
        fmt = string.upper,
        padding = { left = 1 },
        cond = has_enough_room,
      },
      {
        "fileformat",
        symbols = {
          unix = "LF",
          dos = "CRLF",
          mac = "CR",
        },
        padding = { left = 1 },
      },
      components.tabwidth,
    },
    lualine_y = {
      components.separator,
      components.python_venv,
      components.cwd,
    },
    lualine_z = { components.file_location },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
}
