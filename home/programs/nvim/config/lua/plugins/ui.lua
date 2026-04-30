return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = function()
      return require("configs.ui.catppuccin")
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
    keys = require("keymaps.ui.snacks"),
    opts = function()
      return require("configs.ui.snacks")
    end,
  },
}
