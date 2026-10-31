return {
  "sphamba/smear-cursor.nvim",
  -- Neovide animates its own cursor; this plugin is for terminals.
  cond = not vim.g.neovide,
  opts = {},
}
