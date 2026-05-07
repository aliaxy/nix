local settings = require("core.settings")
local icon_sets = require("utils.icons")

local icons = {
  ui = icon_sets.get("ui"),
}

local dashboard_icons = {
  documents = icon_sets.get("documents", true),
  git = icon_sets.get("git", true),
  misc = icon_sets.get("misc", true),
  ui = icon_sets.get("ui", true),
}

local function dashboard_footer()
  local stats = require("lazy.stats").stats()
  local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
  local version = vim.version()

  -- Show the useful parts of nvimdots' alpha footer without copying its wording.
  return {
    align = "center",
    padding = 1,
    text = {
      { " neovim ",                                                        hl = "footer" },
      { ("v%d.%d.%d"):format(version.major, version.minor, version.patch), hl = "special" },
      { " loaded ",                                                        hl = "footer" },
      { stats.loaded .. "/" .. stats.count,                                hl = "special" },
      { " plugins in ",                                                    hl = "footer" },
      { ms .. "ms",                                                        hl = "special" },
    },
  }
end

return {
  -- Keep very large or minified files responsive by disabling expensive features.
  bigfile = {
    enabled = settings.load_big_files_faster,
    notify = true,
    -- Size threshold in bytes; line_length catches minified files with huge lines.
    size = 1.5 * 1024 * 1024,
    line_length = 1000,
  },

  -- Keep the startup screen inside snacks.nvim to avoid a separate dashboard plugin.
  dashboard = {
    enabled = settings.dashboard_enabled,
    width = 50,
    row = nil,
    col = nil,
    pane_gap = 4,
    autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
    preset = {
      header = table.concat(settings.dashboard_header, "\n"),
      keys = {
        {
          icon = dashboard_icons.misc.Neovim,
          key = "s",
          desc = "smart find",
          action = function()
            Snacks.picker.smart()
          end,
        },
        {
          icon = dashboard_icons.documents.Word,
          key = "g",
          desc = "grep text",
          action = function()
            Snacks.picker.grep()
          end,
        },
        {
          icon = dashboard_icons.ui.FolderWithHeart,
          key = "p",
          desc = "projects",
          action = function()
            Snacks.picker.projects()
          end,
        },
        {
          icon = dashboard_icons.documents.Files,
          key = "r",
          desc = "recent files",
          action = function()
            Snacks.picker.recent()
          end,
        },
        { icon = dashboard_icons.ui.SignOut, key = "q", desc = "quit", action = ":qa" },
      },
    },
    sections = {
      { section = "header" },
      { section = "keys",  gap = 1, padding = 1 },
      dashboard_footer,
    },
  },

  -- Optional focus mode: keep configured, but enable it only through the toggle keymap.
  dim = {
    enabled = false,
    scope = {
      min_size = 5,
      max_size = 20,
      siblings = true,
    },
    animate = {
      enabled = false,
    },
    filter = function(buf)
      return vim.g.snacks_dim ~= false and vim.b[buf].snacks_dim ~= false and vim.bo[buf].buftype == ""
    end,
  },

  -- Indent guides and current-scope highlighting. Animation stays disabled to
  -- keep movement quiet and predictable.
  indent = {
    enabled = true,
    indent = {
      enabled = true,
      char = "│",
      only_scope = false,
      only_current = false,
      hl = "SnacksIndent",
    },
    animate = {
      enabled = false,
      style = "out",
      easing = "linear",
      duration = {
        step = 20,
        total = 500,
      },
    },
    scope = {
      enabled = true,
      char = "│",
      underline = false,
      only_current = false,
      hl = "SnacksIndentScope",
    },
    chunk = {
      enabled = false,
    },
  },

  -- Better vim.ui.input() with a small floating prompt. The input buffer keeps
  -- completion disabled so blink.cmp does not take over simple prompts.
  input = {
    enabled = true,
    icon = icons.ui.Pencil .. " ",
    icon_hl = "SnacksInputIcon",
    icon_pos = "left",
    prompt_pos = "title",
    win = { style = "input" },
    expand = true,
  },

  -- snacks.notifier replaces nvimdots' nvim-notify setup.
  notifier = {
    enabled = true,
    timeout = 3000,
    width = { min = 40, max = 0.4 },
    height = { min = 1, max = 0.6 },
    margin = { top = 0, right = 1, bottom = 0 },
    padding = true,
    gap = 0,
    sort = { "level", "added" },
    level = vim.log.levels.TRACE,
    style = "compact",
    top_down = true,
    date_format = "%R",
    more_format = " ↓ %d lines ",
    refresh = 50,
    keep = function()
      return vim.fn.getcmdpos() > 0
    end,
  },

  -- snacks.picker replaces the nvimdots telescope/fzf picker stack.
  picker = {
    enabled = true,
    ui_select = true,
    prompt = icons.ui.ChevronRight .. " ",
    focus = "input",
    show_delay = 500,
    limit_live = 10000,
    layout = {
      cycle = true,
      preset = function()
        return vim.o.columns >= 120 and "default" or "vertical"
      end,
    },
    matcher = {
      fuzzy = true,
      smartcase = true,
      ignorecase = true,
      sort_empty = false,
      filename_bonus = true,
      file_pos = true,
      cwd_bonus = false,
      frecency = false,
      history_bonus = false,
    },
    sort = {
      fields = { "score:desc", "#text", "idx" },
    },
    formatters = {
      file = {
        filename_first = false,
        truncate = 40,
      },
    },
  },

  -- Render the initial file as early as possible when opening Neovim with a path.
  quickfile = {
    enabled = true,
  },

  -- Auto-show LSP document highlights and allow reference navigation later.
  words = {
    enabled = true,
    debounce = 200,
    notify_jump = false,
    notify_end = true,
    foldopen = true,
    jumplist = true,
    modes = { "n", "i", "c" },
  },

  -- Inactive snacks modules kept as a checklist. Enable these one at a time
  -- when their behavior is explicitly wanted.
  -- explorer = { enabled = true },
  -- scope = { enabled = true },
  -- scroll = { enabled = true },
  -- statuscolumn = { enabled = true },
  -- lazygit = { enabled = true },
  -- terminal = { enabled = true },
  -- scratch = { enabled = true },
  -- zen = { enabled = true },

  styles = {
    input = {
      backdrop = false,
      position = "float",
      border = true,
      title_pos = "center",
      height = 1,
      width = 60,
      relative = "editor",
      noautocmd = true,
      row = 2,
      wo = {
        winhighlight = "NormalFloat:SnacksInputNormal,FloatBorder:SnacksInputBorder,FloatTitle:SnacksInputTitle",
        cursorline = false,
      },
      bo = {
        filetype = "snacks_input",
        buftype = "prompt",
      },
      b = {
        completion = false,
      },
      keys = {
        n_esc = { "<esc>", { "cmp_close", "cancel" }, mode = "n", expr = true },
        i_esc = { "<esc>", { "cmp_close", "stopinsert" }, mode = "i", expr = true },
        i_cr = { "<cr>", { "cmp_accept", "confirm" }, mode = { "i", "n" }, expr = true },
        i_tab = { "<tab>", { "cmp_select_next", "cmp" }, mode = "i", expr = true },
        i_ctrl_w = { "<c-w>", "<c-s-w>", mode = "i", expr = true },
        i_up = { "<up>", { "hist_up" }, mode = { "i", "n" } },
        i_down = { "<down>", { "hist_down" }, mode = { "i", "n" } },
        q = "cancel",
      },
    },
    notification = {
      border = true,
      zindex = 100,
      ft = "markdown",
      wo = {
        winblend = 5,
        wrap = true,
        conceallevel = 2,
        colorcolumn = "",
      },
      bo = { filetype = "snacks_notif" },
    },
    notification_history = {
      border = true,
      zindex = 100,
      width = 0.6,
      height = 0.6,
      minimal = false,
      title = " Notification History ",
      title_pos = "center",
      ft = "markdown",
      bo = { filetype = "snacks_notif_history", modifiable = false },
      wo = { winhighlight = "Normal:SnacksNotifierHistory" },
      keys = { q = "close" },
    },
    dashboard = {
      wo = {
        sidescrolloff = 0,
        smoothscroll = false,
        wrap = false,
      },
    },
  },
}
