local settings = require("core.settings")
local global = require("core.global")
local capabilities = require("configs.lsp.capabilities")

local function enable(name, config)
  local cmd = config.cmd and config.cmd[1]
  if cmd and not global.executable(cmd) then
    return false
  end

  config.capabilities = vim.tbl_deep_extend("force", capabilities, config.capabilities or {})
  vim.lsp.config(name, config)
  vim.lsp.enable(name)
  return true
end

if settings.lsp_servers.lua == "lua_ls" then
  enable("lua_ls", {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", ".git" },
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        runtime = { version = "LuaJIT" },
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
            global.config_dir,
          },
        },
        telemetry = { enable = false },
      },
    },
  })
end

for _, server in ipairs(settings.lsp_servers.nix) do
  local enabled = enable(server, {
    cmd = { server == "nil_ls" and "nil" or server },
    filetypes = { "nix" },
    root_markers = { "flake.nix", "default.nix", ".git" },
  })
  if enabled then
    break
  end
end

if settings.lsp_servers.shell == "bashls" then
  enable("bashls", {
    cmd = { "bash-language-server", "start" },
    filetypes = { "sh", "bash", "zsh" },
    root_markers = { ".git" },
  })
end
