-- User-local tools (tree-sitter-cli, etc.). Windows separates PATH entries
-- with ";" -- using ":" there glues ~/.local/bin onto the first real entry
-- (usually System32, home of tar.exe and curl.exe) and breaks it.
local path_sep = vim.fn.has("win32") == 1 and ";" or ":"
vim.env.PATH = vim.fs.normalize("~/.local/bin") .. path_sep .. (vim.env.PATH or "")

-- Neovim 0.13 looks here for compiled treesitter parsers (vimdoc, lua, ...)
vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/site")

-- Bootstrap lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- :helptags now requires a vimdoc parser. lazy.nvim calls it while installing
-- plugins, which used to abort startup before treesitter could install one.
do
  local ok_help, help = pcall(require, "lazy.help")
  if ok_help and help.update then
    local orig = help.update
    help.update = function(...)
      local ok, err = pcall(orig, ...)
      if not ok then
        vim.notify("lazy helptags skipped: " .. tostring(err), vim.log.levels.WARN)
      end
    end
  end
end

require("lazy").setup(
    {
        { import = "logan.plugins" },
        { import = "logan.plugins.lsp" },
    }, 
    {
        checker = {
            enabled = true,
            notify = false,
        },
        change_detection = {
            notify = false,
        }
    }
)
