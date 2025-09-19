return {
    "ryanoasis/vim-devicons",
    lazy = false,
    init = function()
        vim.g.webdevicons_enable = 1
        vim.g.webdevicons_enable_nerdtree = 1
        vim.g.webdevicons_enable_nerdtree_brackets = 1
        vim.g.webdevicons_enable_airline_statusline = 1
        vim.g.webdevicons_enable_airline_tabline = 1

        vim.g.WebDevIconsUnicodeDecorateFolderNodes = 1
        vim.g.DevIconsEnableFoldersOpenClose = 1
    end,
}
