vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.python3_host_prog='/nix/store/yfzdsy2pc8yp3qym25s8a4mr4br9gpdc-nvim-host-python3-3.13.12-env/bin/nvim-python3'

if vim.loader then
  vim.loader.enable()
end

vim.o.background = require("core.settings").background

require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.lazy")
