return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")
        local map = require("utils.keymap").buf_set

        map(bufnr, "n", "]h", function()
          gitsigns.nav_hunk("next")
        end, "Next git hunk")

        map(bufnr, "n", "[h", function()
          gitsigns.nav_hunk("prev")
        end, "Previous git hunk")

        map(bufnr, "n", "<leader>ghs", gitsigns.stage_hunk, "Stage hunk")
        map(bufnr, "n", "<leader>ghr", gitsigns.reset_hunk, "Reset hunk")
        map(bufnr, "v", "<leader>ghs", function()
          local start_line = vim.api.nvim_buf_get_mark(0, "<")[1]
          local end_line = vim.api.nvim_buf_get_mark(0, ">")[1]
          gitsigns.stage_hunk({ start_line, end_line })
        end, "Stage hunk")
        map(bufnr, "v", "<leader>ghr", function()
          local start_line = vim.api.nvim_buf_get_mark(0, "<")[1]
          local end_line = vim.api.nvim_buf_get_mark(0, ">")[1]
          gitsigns.reset_hunk({ start_line, end_line })
        end, "Reset hunk")
        map(bufnr, "n", "<leader>ghp", gitsigns.preview_hunk, "Preview hunk")
        map(bufnr, "n", "<leader>ghb", gitsigns.blame_line, "Blame line")
      end,
    },
  },
}
