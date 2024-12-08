vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.autoformat = true
vim.g.lazyvim_picker = "telescope"
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

vim.g.lazygit_config = true

local opt = vim.opt

opt.autowrite = true                                    -- Enable auto write
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 2                                    -- Hide * markup for bold and italic, but not markers with substitutions
opt.confirm = true                                      -- Confirm to save changes before exiting modified buffer
opt.cursorline = true                                   -- Enable highlighting of the current line
opt.expandtab = true                                    -- Use spaces instead of tabs
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.softtabstop = 2
opt.termguicolors = true
opt.relativenumber = true
opt.numberwidth = 8
