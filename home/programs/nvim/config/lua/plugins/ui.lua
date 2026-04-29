return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = function()
      local settings = require("core.settings")
      return {
        flavour = settings.colorscheme_flavour,
        transparent_background = settings.transparent_background,
        integrations = {
          blink_cmp = true,
          gitsigns = true,
          native_lsp = {
            enabled = true,
          },
          snacks = true,
          treesitter = true,
        },
      }
    end,
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme(require("core.settings").colorscheme)
    end,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = function()
      return require("configs.ui.snacks")
    end,
  },
}
