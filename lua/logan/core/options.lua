vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.hidden = true
vim.opt.hlsearch = false
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

-- Neovide (GUI) only. vim.g.neovide is set before init.lua runs.
if vim.g.neovide then
    vim.o.guifont = "0xProto Nerd Font:h14" -- :hN is the point size
end
