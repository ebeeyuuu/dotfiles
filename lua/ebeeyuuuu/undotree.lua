vim.cmd([[
  call plug#begin('~/.local/share/nvim/plugged/')
    Plug 'mbbill/undotree'
  call plug#end()
]])

vim.keymap.set("n", "<leader>u", "UndotreeShow")
vim.keymap.set("n", "<leader>U", "UndotreeToggle")
vim.keymap.set("n", "<leader>r", "UndotreeFocus")
vim.keymap.set("n", "<leader>R", "UndotreeFocusRestore")
