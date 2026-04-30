local M = {}

-- Query the host operating system once during startup.
local uname = vim.uv.os_uname()
local sysname = uname.sysname or ""

-- Platform flags used by cross-platform config branches.
M.is_macos = sysname == "Darwin"
M.is_linux = sysname == "Linux"
M.is_windows = sysname == "Windows_NT"

-- Use Neovim's built-in WSL detection instead of maintaining our own heuristic.
M.is_wsl = vim.fn.has("wsl") == 1

-- Common runtime paths. Keep stdpath calls centralized here.
M.home = vim.uv.os_homedir()
M.config_dir = vim.fs.normalize(vim.fn.stdpath("config"))
M.cache_dir = vim.fs.normalize(vim.fn.stdpath("cache"))
M.data_dir = vim.fs.normalize(vim.fn.stdpath("data"))
M.state_dir = vim.fs.normalize(vim.fn.stdpath("state"))

--- Join path segments using Neovim's normalized filesystem helper.
---@param ... string Path segments.
---@return string path Normalized joined path.
function M.path_join(...)
  return vim.fs.normalize(vim.fs.joinpath(...))
end

--- Return true when an executable can be found in PATH.
---@param name string Executable name to search for, such as "git" or "stylua".
---@return boolean found True if the executable exists and can be executed.
function M.executable(name)
  return vim.fn.executable(name) == 1
end

return M
