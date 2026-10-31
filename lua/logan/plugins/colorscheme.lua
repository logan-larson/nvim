return {
    "bluz71/vim-nightfly-guicolors", -- Change this color scheme eventually
    priority = 1000,
    config = function()
        -- In Neovide there is no terminal behind the window, so a cleared
        -- Normal background just shows Neovide's default instead of nightfly's.
        vim.g.nightflyTransparent = not vim.g.neovide
        vim.cmd("syntax on")
        vim.cmd("filetype plugin indent on")
        vim.cmd([[colorscheme nightfly]])
    end
}
