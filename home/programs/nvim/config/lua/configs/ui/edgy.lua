local function trouble_filter(position)
  return function(_, win)
    local trouble = vim.w[win].trouble
    return trouble
      and trouble.position == position
      and trouble.type == "split"
      and trouble.relative == "editor"
      and not vim.w[win].trouble_preview
  end
end

return {
  -- Keep edgebar changes instant and quiet, matching the nvimdots behavior.
  animate = { enabled = false },
  close_when_all_hidden = true,
  exit_when_last = true,
  wo = { winbar = false },
  keys = {
    q = false,
    Q = false,
    ["<C-q>"] = false,
    ["<A-j>"] = function(win)
      win:resize("height", -2)
    end,
    ["<A-k>"] = function(win)
      win:resize("height", 2)
    end,
    ["<A-h>"] = function(win)
      win:resize("width", -2)
    end,
    ["<A-l>"] = function(win)
      win:resize("width", 2)
    end,
  },
  left = {
    -- Enable after adding a file tree plugin.
    -- {
    --   ft = "NvimTree",
    --   pinned = true,
    --   collapsed = false,
    --   size = { height = 0.6, width = 0.15 },
    --   open = "NvimTreeOpen",
    -- },

    -- Enable after adding trouble.nvim symbols.
    -- {
    --   ft = "trouble",
    --   pinned = true,
    --   collapsed = false,
    --   size = { height = 0.4, width = 0.15 },
    --   open = function()
    --     return vim.b.buftype == "" and "Trouble symbols toggle win.position=right"
    --   end,
    --   filter = trouble_filter("right"),
    -- },
  },
  bottom = {
    { ft = "qf", size = { height = 0.3 } },

    -- Enable after adding toggleterm.nvim.
    -- {
    --   ft = "toggleterm",
    --   size = { height = 0.3 },
    --   filter = function(_, win)
    --     local ok, terminal = pcall(require, "toggleterm.terminal")
    --     if not ok then
    --       return false
    --     end
    --
    --     local cfg = vim.api.nvim_win_get_config(win)
    --     local term = terminal.get(1)
    --     return cfg.relative == "" and term and term.direction == "horizontal"
    --   end,
    -- },

    {
      ft = "help",
      size = { height = 0.3 },
      filter = function(buf)
        return vim.bo[buf].buftype == "help"
      end,
    },
  },
  right = {
    -- Enable after adding CodeCompanion.
    -- {
    --   ft = "codecompanion",
    --   pinned = true,
    --   collapsed = false,
    --   size = { width = 0.25 },
    --   open = "CodeCompanionChat Toggle",
    -- },
  },
}
