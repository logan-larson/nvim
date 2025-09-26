return {
    "vim-airline/vim-airline",
    dependencies = {
        "vim-airline/vim-airline-themes",
        "ryanoasis/vim-devicons"
    },
    event = "VeryLazy",
    init = function()
        vim.g["airline#extensions#tabline#enabled"] = 1
        vim.g["airline#extensions#tabline#show_buffers"] = 1
        vim.g["airline#extensions#tabline#show_tabs"] = 0
        vim.g["airline#extensions#tabline#buffer_idx_mode"] = 1
        vim.g["airline#extensions#tabline#formatter"] = "unique_tail"
        vim.g["airline_powerline_fonts"] = 1

        vim.g["airline_left_sep"] = ' '
        vim.g["airline_left_alt_sep"] = ' '
        vim.g["airline_right_sep"] = ' '
        vim.g["airline_right_alt_sep"] = ' '

        vim.g["airline#extensions#tabline#left_sep"] = ' '
        vim.g["airline#extensions#tabline#left_alt_sep"] = ' '
        vim.g["airline#extensions#tabline#right_sep"] = ' '
        vim.g["airline#extensions#tabline#right_alt_sep"] = ' '
    end,
    config = function()
        -- Simple airline configuration - just enable tabline
        vim.opt.termguicolors = true
        vim.opt.showtabline = 2

        for i = 1,9 do
            vim.keymap.set("n", "<leader>" .. i, "<Plug>AirlineSelectTab" .. i, { silent = true, desc = "Airline buffer " .. i })
        end
        vim.keymap.set("n", "<leader>0", "<Plug>AirlineSelectTabLast", { silent = true, desc = "Airline last buffer" })
    end,
}
