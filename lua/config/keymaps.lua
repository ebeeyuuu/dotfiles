-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.api.nvim_set_keymap("n", "yy", "1GvG$y", { noremap = true, silent = true })

-- Telescope keymaps
vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Space>e", ":Telescope file_browser<cr>", { noremap = true, silent = true })

-- Buffer keymaps
vim.api.nvim_set_keymap("n", "BB", ":BufferClose<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
  "n",
  "B",
  [[:lua vim.cmd('BufferGoto ' .. string.char(vim.fn.getchar()))<CR>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "BJ", ":BufferNext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "BL", ":BufferPrevious<CR>", { noremap = true, silent = true })
