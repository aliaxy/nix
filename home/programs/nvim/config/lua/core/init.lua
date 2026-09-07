vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
-- python3_host_prog is set by Home Manager (programs.neovim.withPython3).

if vim.loader then
  vim.loader.enable()
end

vim.o.background = require("core.settings").background

require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.lazy")
