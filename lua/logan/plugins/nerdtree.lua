return {
    "preservim/nerdtree",
    cmd = { "NERDTree", "NERDTreeToggle", "NERDTreeFind", "NERDTreeClose" },
    init = function()
        -- Auto open NERDTree when opening a directory
        vim.api.nvim_create_autocmd("StdinReadPre", {
            group = vim.api.nvim_create_augroup("NERDTree", {}),
            pattern = "*",
            callback = function()
                vim.cmd("let s:std_in=1")
            end,
        })

        vim.api.nvim_create_autocmd("VimEnter", {
            group = vim.api.nvim_create_augroup("NERDTree", {}),
            pattern = "*",
            callback = function()
                if vim.fn.argc() == 0 and vim.fn.exists("s:std_in") == 0 then
                    vim.cmd("NERDTree")
                end
            end,
        })

        -- Close vim if NERDTree is the only window left
        vim.api.nvim_create_autocmd("BufEnter", {
            group = vim.api.nvim_create_augroup("NERDTree", {}),
            pattern = "*",
            callback = function()
                if vim.fn.winnr("$") == 1 and vim.fn.exists("b:NERDTree") == 1 then
                    vim.cmd("quit")
                end
            end,
        })
    end,
    config = function()
        -- NERDTree configuration
        vim.g.NERDTreeShowHidden = 1
        vim.g.NERDTreeMinimalUI = 1
        vim.g.NERDTreeDirArrows = 1
        vim.g.NERDTreeAutoDeleteBuffer = 1
        vim.g.NERDTreeQuitOnOpen = 0
        vim.g.NERDTreeWinSize = 30
    end,
}
