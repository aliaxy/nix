vim.g.mapleader = " "
vim.g.maplocalleader = " "

if vim.loader then
  vim.loader.enable()
end

vim.o.background = require("core.settings").background

require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.lazy")
