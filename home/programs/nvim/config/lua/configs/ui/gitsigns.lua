return {
  -- Match the compact sign style used by nvimdots while keeping colors theme-driven.
  signs = {
    add = { text = "┃" },
    change = { text = "┃" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "┆" },
  },
  auto_attach = true,
  -- Keymaps live under lua/keymaps and are attached only to git-aware buffers.
  on_attach = require("keymaps.ui.gitsigns").on_attach,
  signcolumn = true,
  sign_priority = 6,
  update_debounce = 100,
  word_diff = false,
  -- Show blame inline by default, with the explicit blame keymap still available.
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 500,
    virt_text = true,
    virt_text_pos = "eol",
  },
  -- Use gitsigns' internal diff and keep signs following moved or renamed files.
  diff_opts = {
    internal = true,
  },
  watch_gitdir = {
    follow_files = true,
  },
}
