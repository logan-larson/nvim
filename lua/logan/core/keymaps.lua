vim.g.mapleader = " "

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Comment.nvim custom keybinds
map("n", "<C-_>", function()
    require("Comment.api").toggle.linewise.current()
end, opts)

map("v", "<C-_>", function()
    local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
    vim.api.nvim_feedkeys(esc, "x", false)
    require("Comment.api").toggle.linewise(vim.fn.visualmode())
end, opts)

map("n", "<leader>e", "<cmd>Ex<cr>", opts)

-- Buffer navigation keymaps
map("n", "<leader>h", "<cmd>bprevious<cr>", opts)  -- Previous buffer
map("n", "<leader>l", "<cmd>bnext<cr>", opts)      -- Next buffer
map("n", "<leader>[", "<cmd>bfirst<cr>", opts)     -- First buffer
map("n", "<leader>]", "<cmd>blast<cr>", opts)      -- Last buffer
map("n", "<leader>q", "<cmd>bprevious <BAR> bdelete #<cr>", opts)    -- Close current buffer

-- Window navigation keymaps
map("n", "<C-J>", "<C-W><C-J>", opts)
map("n", "<C-K>", "<C-W><C-K>", opts)
map("n", "<C-L>", "<C-W><C-L>", opts)
map("n", "<C-H>", "<C-W><C-H>", opts)

-- Line navigation keymaps
map("n", "H", "^", opts)
map("n", "L", "$", opts)
map("v", "H", "^", opts)
map("v", "L", "$", opts)

-- NERDTree keymaps
map("n", "<C-n>", "<cmd>NERDTreeToggle<cr>", opts)     -- Toggle NERDTree
-- map("n", "<leader>f", "<cmd>NERDTreeFind<cr>", opts)       -- Find current file in NERDTree
