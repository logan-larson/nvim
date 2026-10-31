vim.g.mapleader = " "

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Comment.nvim custom keybinds. Terminals deliver Ctrl+/ as <C-_>; GUIs such
-- as Neovide deliver it as <C-/>, so bind both.
local function toggle_comment_line()
    require("Comment.api").toggle.linewise.current()
end

local function toggle_comment_selection()
    local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
    vim.api.nvim_feedkeys(esc, "x", false)
    require("Comment.api").toggle.linewise(vim.fn.visualmode())
end

for _, key in ipairs({ "<C-_>", "<C-/>" }) do
    map("n", key, toggle_comment_line, opts)
    map("v", key, toggle_comment_selection, opts)
end

map("n", "<leader>e", "<cmd>Ex<cr>", opts)

-- Buffer navigation keymaps
map("n", "<leader>h", "<cmd>bprevious<cr>", opts)  -- Previous buffer
map("n", "<leader>l", "<cmd>bnext<cr>", opts)      -- Next buffer
map("n", "<leader>[", "<cmd>bfirst<cr>", opts)     -- First buffer
map("n", "<leader>]", "<cmd>blast<cr>", opts)      -- Last buffer
map("n", "<leader>q", "<cmd>bprevious <BAR> bdelete #<cr>", opts)    -- Close current buffer

-- Window navigation keymaps
map("n", "<C-J>", "<C-W><C-J>", opts)
map("n", "<C-K>", "<C-W><C-K>", opts)
map("n", "<C-L>", "<C-W><C-L>", opts)
map("n", "<C-H>", "<C-W><C-H>", opts)

-- Line navigation keymaps
map("n", "H", "^", opts)
map("n", "L", "$", opts)
map("v", "H", "^", opts)
map("v", "L", "$", opts)

-- NERDTree keymaps
map("n", "<C-n>", "<cmd>NERDTreeToggle<cr>", opts)     -- Toggle NERDTree
-- map("n", "<leader>f", "<cmd>NERDTreeFind<cr>", opts)       -- Find current file in NERDTree

-- System clipboard shortcuts for GUI Neovim (Neovide). Terminals handle
-- Ctrl+Shift+V / Shift+Insert themselves and never forward them, so these
-- are inert there. Without any mapping, <C-r>+ pastes in insert, command-line
-- and prompt modes, and "+p pastes in normal mode.
map("v", "<C-S-c>", '"+y', opts) -- copy selection
for _, key in ipairs({ "<C-S-v>", "<S-Insert>" }) do
    map({ "n", "v" }, key, '"+P', opts)
    map("i", key, "<C-r><C-o>+", opts) -- insert literally, no auto-indent
    map("c", key, "<C-r>+", { noremap = true })
end

-- Neovide zoom: Ctrl+= / Ctrl+- scale the whole UI, Ctrl+0 resets.
-- Change the base size via guifont in core/options.lua.
if vim.g.neovide then
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor or 1.0
    local function zoom(delta)
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end
    map("n", "<C-=>", function() zoom(1.1) end, opts)
    map("n", "<C-->", function() zoom(1 / 1.1) end, opts)
    map("n", "<C-0>", function() vim.g.neovide_scale_factor = 1.0 end, opts)
end
