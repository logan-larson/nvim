return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local telescope = require("telescope")

        telescope.setup({
            defaults = {
                mappings = {
                    n = {
                        ["d"] = require("telescope.actions").delete_buffer,
                        ["q"] = require("telescope.actions").close,
                    }
                }
            },
            pickers = {
                find_files = {
                    hidden = false,
                    no_ignore = false,
                }
            }
        })

        -- Built by telescope-fzf-native's `make` step; skip if the .so is missing
        -- so a failed compile cannot abort Neovim startup.
        local ok, err = pcall(telescope.load_extension, "fzf")
        if not ok then
            vim.notify("telescope-fzf-native is not built: " .. tostring(err), vim.log.levels.WARN)
        end

        -- Telescope keybinds
        local map = vim.keymap.set

        map("n", "<leader>ff", "<cmd>Telescope find_files theme=ivy hidden=false<cr>", { desc = "Find files" })
        map("n", "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true initial_mode=normal theme=ivy<cr>", { desc = "Open buffers" })
        map("n", "<leader>fg", "<cmd>Telescope live_grep initial_mode=normal theme=ivy<cr>", { desc = "Find string in cwd" })
        map("n", "<leader>fc", "<cmd>Telescope grep_string initial_mode=normal theme=ivy<cr>", { desc = "Find string under cursor in cwd" })
    end,
}
