vim.g.mapleader = " "

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap("n", "<leader>l", ":bnext<CR>", opts)
keymap("n", "<leader>h", ":bprevious<CR>", opts)
keymap("n", "<leader>]", ":blast<CR>", opts)
keymap("n", "<leader>[", ":bfirst<CR>", opts)
keymap("n", "<leader>q", ":bp <BAR> bd #<CR>", opts)
keymap("n", "<C-n>", ":NERDTreeToggle<CR>", opts)
keymap("n", "<C-p>", ":GFiles<CR>", opts)
keymap("n", "<C-b>", ":Buffers<CR>", opts)

