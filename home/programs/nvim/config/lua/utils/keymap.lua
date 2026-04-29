local M = {}

function M.set(mode, lhs, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set(mode, lhs, rhs, opts)
end

function M.buf_set(bufnr, mode, lhs, rhs, desc, opts)
  opts = opts or {}
  opts.buffer = bufnr
  opts.desc = desc
  vim.keymap.set(mode, lhs, rhs, opts)
end

return M
