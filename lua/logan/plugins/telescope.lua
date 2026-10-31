return {
    'nvim-telescope/telescope.nvim',
    -- 0.1.x never passes LSP position_encoding; Neovim 0.13 requires it
    -- for gd/gR/gi/gt (definitions, references, implementations, type defs).
    branch = 'master',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            -- GNU make is not part of MSVC, so build with CMake on Windows
            -- (needs cmake + Visual Studio Build Tools). Output: build/libfzf.dll
            build = vim.fn.has("win32") == 1
                and "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install"
                or "make",
        },
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

        -- Built by telescope-fzf-native's build step; skip if the .so/.dll is missing
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
