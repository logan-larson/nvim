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
