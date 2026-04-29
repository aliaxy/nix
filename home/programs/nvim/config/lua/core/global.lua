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

--- Return true when an executable can be found in PATH.
---@param name string Executable name to search for, such as "git" or "stylua".
---@return boolean found True if the executable exists in PATH.
function M.executable(name)
  local path_env = vim.env.PATH
  if not path_env or path_env == "" then
    return false
  end

  -- Windows may resolve executables through PATHEXT, e.g. foo.exe or foo.cmd.
  local separator = M.is_windows and ";" or ":"
  local extensions = { "" }
  if M.is_windows then
    extensions = vim.split(vim.env.PATHEXT or ".EXE;.CMD;.BAT;.COM", ";", { plain = true, trimempty = true })
    table.insert(extensions, 1, "")
  end

  -- Resolve candidates with libuv so the check stays shell-independent.
  for dir in vim.gsplit(path_env, separator, { plain = true, trimempty = true }) do
    for _, extension in ipairs(extensions) do
      local candidate = vim.fs.joinpath(dir, name .. extension)
      local stat = vim.uv.fs_stat(candidate)
      if stat and stat.type == "file" then
        return true
      end
    end
  end

  return false
end

return M
