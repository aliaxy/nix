local augroup = vim.api.nvim_create_augroup("aliaxy_core", { clear = true })

-- Create a directory and its missing parents using libuv primitives.
local function mkdir_p(path)
  local normalized = vim.fs.normalize(path)
  local parent = vim.fs.dirname(normalized)
  if parent and not vim.uv.fs_stat(parent) then
    mkdir_p(parent)
  end

  if not vim.uv.fs_stat(normalized) then
    vim.uv.fs_mkdir(normalized, 493)
  end
end

-- Treat transient buffers as disposable UI and close them with `q`.
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = {
    "qf",
    "help",
    "man",
    "notify",
    "nofile",
    "terminal",
    "prompt",
    "toggleterm",
    "copilot",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true, desc = "Close window" })
  end,
  desc = "Close temporary windows with q",
})

-- Briefly highlight text after yank so the copied range is visible.
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  callback = function()
    vim.hl.on_yank({ timeout = 150 })
  end,
  desc = "Highlight yanked text",
})

-- Return to the last known cursor position when reopening a file.
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
  callback = function(event)
    local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(event.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = "Restore cursor position",
})

-- Avoid writing persistent undo files for temporary or VCS message buffers.
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  pattern = { "*~", "/tmp/*", "*.tmp", "*.bak", "MERGE_MSG", "description", "COMMIT_EDITMSG" },
  callback = function()
    vim.opt_local.undofile = false
  end,
  desc = "Disable undo files for temporary buffers",
})

-- Keep cursorline only in the active editing context.
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "InsertLeave" }, {
  group = augroup,
  callback = function()
    if vim.bo.filetype ~= "dashboard" and not vim.wo.previewwindow then
      vim.wo.cursorline = true
    end
  end,
  desc = "Enable cursorline in active windows",
})

-- Hide cursorline in inactive windows and during insert mode to reduce visual noise.
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave", "InsertEnter" }, {
  group = augroup,
  callback = function()
    if vim.bo.filetype ~= "dashboard" and not vim.wo.previewwindow then
      vim.wo.cursorline = false
    end
  end,
  desc = "Disable cursorline in inactive windows",
})

-- Persist ShaDa explicitly on exit so marks, registers, and history survive cleanly.
vim.api.nvim_create_autocmd("VimLeave", {
  group = augroup,
  command = "wshada",
  desc = "Write ShaDa on exit",
})

-- Check whether focused buffers changed on disk while Neovim was unfocused.
vim.api.nvim_create_autocmd("FocusGained", {
  group = augroup,
  command = "checktime",
  desc = "Check whether files changed outside Neovim",
})

-- Rebalance split sizes when the terminal or GUI frame is resized.
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup,
  command = "tabdo wincmd =",
  desc = "Resize splits when the terminal changes size",
})

-- Stop new lines from automatically continuing comments after pressing Enter or `o`.
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
  desc = "Disable automatic comment continuation",
})

-- Wrap prose-oriented Markdown buffers while keeping code buffers unwrapped.
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
  end,
  desc = "Wrap Markdown buffers",
})

-- Create missing parent directories before writing a new file path.
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end

    local file = vim.uv.fs_realpath(event.match) or event.match
    local dir = vim.fs.dirname(file)
    if dir and not vim.uv.fs_stat(dir) then
      pcall(mkdir_p, dir)
    end
  end,
  desc = "Create parent directories before writing",
})
