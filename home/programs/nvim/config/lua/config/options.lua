-- options.lua
-- LazyVim already sets sensible defaults; only override what you actually want different

local opt = vim.opt

-- Line numbers
opt.relativenumber = true
opt.number = true

-- Indentation (LazyVim defaults to 2, change if you prefer 4)
opt.tabstop = 4
opt.shiftwidth = 4

-- Keep undo history across sessions
opt.undofile = true

-- Sync clipboard with system clipboard
opt.clipboard = "unnamedplus"
