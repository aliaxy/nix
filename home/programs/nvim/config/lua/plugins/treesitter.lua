return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = function()
      require("nvim-treesitter").install(require("core.settings").treesitter_parsers):wait(300000)
    end,
    opts = function()
      return {
        ensure_installed = require("core.settings").treesitter_parsers,
      }
    end,
    config = function(_, opts)
      require("nvim-treesitter").setup()

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("personal_treesitter", { clear = true }),
        pattern = opts.ensure_installed,
        callback = function()
          pcall(vim.treesitter.start)
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
        desc = "Enable Treesitter highlighting and indentation",
      })
    end,
  },
}
