return {
    "bluz71/vim-nightfly-guicolors", -- Change this color scheme eventually
    priority = 1000,
    config = function()
        vim.g.nightflyTransparent = true
        vim.cmd("syntax on")
        vim.cmd("filetype plugin indent on")
        vim.cmd([[colorscheme nightfly]])
    end
}
