return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    },
    config = function()
        local mason = require("mason")

        local mason_lspconfig = require("mason-lspconfig")

        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                }
            }
        })

        -- Always install these. Mason can fetch them without an extra toolchain.
        local ensure_installed = {
            "ts_ls",
            "html",
            "tailwindcss",
            "svelte",
            "lua_ls",
        }

        -- Keep these listed so you remember which server goes with which language,
        -- but only auto-install when that toolchain is actually on PATH.
        local optional_servers = {
            { server = "gopls", bins = { "go" } },
            { server = "rust_analyzer", bins = { "rustc", "cargo" } },
        }

        for _, item in ipairs(optional_servers) do
            for _, bin in ipairs(item.bins) do
                if vim.fn.executable(bin) == 1 then
                    table.insert(ensure_installed, item.server)
                    break
                end
            end
        end

        mason_lspconfig.setup({
            ensure_installed = ensure_installed,
            automatic_enable = true,
        })
    end
}
