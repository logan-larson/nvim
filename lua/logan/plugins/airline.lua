return {
    "vim-airline/vim-airline",
    dependencies = {
        "vim-airline/vim-airline-themes"
    },
    event = "VeryLazy",
    init = function()
        vim.g["airline#extensions#tabline#enabled"] = 1
        vim.g["airline#extensions#tabline#show_buffers"] = 1
        vim.g["airline#extensions#tabline#show_tabs"] = 0
        vim.g["airline#extensions#tabline#buffer_idx_mode"] = 1
        vim.g["airline#extensions#tabline#formatter"] = "unique_tail"
        vim.g["airline_powerline_fonts"] = 1
    end,
    config = function()
        -- Simple airline configuration - just enable tabline
        vim.opt.termguicolors = true
    end,
}
