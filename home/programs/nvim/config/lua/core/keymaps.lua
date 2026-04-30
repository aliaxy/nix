local map = vim.keymap.set

-- Save and quit.
map({ "n", "i" }, "<C-s>", "<cmd>write<cr>", { desc = "Write file" })
map("n", "<leader>w", "<cmd>write<cr>", { desc = "Write file" })
map("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit window" })
map("n", "<leader>Q", "<cmd>quitall<cr>", { desc = "Quit all" })

-- Window navigation.
map("n", "<C-h>", "<C-w>h", { desc = "Focus left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Focus lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Focus upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Focus right window" })

-- Window navigation from terminal mode.
map("t", "<C-w>h", "<cmd>wincmd h<cr>", { desc = "Focus left window" })
map("t", "<C-w>j", "<cmd>wincmd j<cr>", { desc = "Focus lower window" })
map("t", "<C-w>k", "<cmd>wincmd k<cr>", { desc = "Focus upper window" })
map("t", "<C-w>l", "<cmd>wincmd l<cr>", { desc = "Focus right window" })

-- Buffers.
map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Previous buffer" })

-- Tabs.
-- map("n", "<leader><tab>n", "<cmd>tabnew<cr>", { desc = "New tab" })
map("n", "<leader><tab>l", "<cmd>tabnext<cr>", { desc = "Next tab" })
map("n", "<leader><tab>h", "<cmd>tabprevious<cr>", { desc = "Previous tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close other tabs" })

-- Folds.
map("n", "<S-Tab>", "za", { desc = "Toggle fold" })

-- Diagnostics.
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "<leader>cl", vim.diagnostic.setloclist, { desc = "Diagnostics loclist" })

-- Package manager: lazy.nvim.
map("n", "<leader>ph", "<cmd>Lazy<cr>", { desc = "Lazy home" })
map("n", "<leader>ps", "<cmd>Lazy sync<cr>", { desc = "Lazy sync" })
map("n", "<leader>pu", "<cmd>Lazy update<cr>", { desc = "Lazy update" })
map("n", "<leader>pi", "<cmd>Lazy install<cr>", { desc = "Lazy install" })
map("n", "<leader>pl", "<cmd>Lazy log<cr>", { desc = "Lazy log" })
map("n", "<leader>pc", "<cmd>Lazy check<cr>", { desc = "Lazy check" })
map("n", "<leader>pd", "<cmd>Lazy debug<cr>", { desc = "Lazy debug" })
map("n", "<leader>pp", "<cmd>Lazy profile<cr>", { desc = "Lazy profile" })
map("n", "<leader>pr", "<cmd>Lazy restore<cr>", { desc = "Lazy restore" })
map("n", "<leader>px", "<cmd>Lazy clean<cr>", { desc = "Lazy clean" })
