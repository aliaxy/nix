-- Install lazy.nvim under Neovim's data directory.
local system = require("utils.system")
local settings = require("core.settings")

local lazypath = system.path_join(system.data_dir, "lazy", "lazy.nvim")
local lazy_url = settings.use_ssh and "git@github.com:folke/lazy.nvim.git" or "https://github.com/folke/lazy.nvim.git"
local url_format = settings.use_ssh and "git@github.com:%s.git" or "https://github.com/%s.git"

-- Bootstrap lazy.nvim if it is not installed yet.
if not vim.uv.fs_stat(lazypath) then
  local result = vim.system({
    "git",
    "clone",
    "--filter=blob:none",
    lazy_url,
    "--branch=stable",
    lazypath,
  }):wait()

  if result.code ~= 0 then
    error(("Failed to clone lazy.nvim:\n%s"):format(result.stderr))
  end
end

-- Make lazy.nvim available before requiring it.
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Load every feature-grouped spec from lua/plugins/*.lua.
  spec = {
    { import = "plugins" },
    vim.tbl_map(function(plugin)
      return { plugin, enabled = false }
    end, settings.disabled_plugins),
  },

  -- Keep plugin network operations predictable and allow SSH/HTTPS switching.
  git = {
    timeout = 300,
    url_format = url_format,
  },

  -- Disable automatic update checks to avoid GitHub API rate limits.
  -- Run :Lazy update manually when you want to update plugins.
  checker = { enabled = false, notify = false },

  -- Avoid noisy notifications when plugin spec files change.
  change_detection = { notify = false },

  -- Install missing plugins on startup and use the configured colorscheme when possible.
  install = {
    missing = true,
    colorscheme = { settings.colorscheme },
  },

  -- Keep lazy.nvim's own UI consistent with the rest of the config.
  ui = {
    border = "rounded",
    size = { width = 0.88, height = 0.8 },
    wrap = true,
  },

  -- macOS handles higher clone/install concurrency comfortably.
  concurrency = system.is_macos and 20 or nil,

  -- Disable unused built-in runtime plugins for a smaller startup surface.
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
