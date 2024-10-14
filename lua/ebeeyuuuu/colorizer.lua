vim.cmd([[
  call plug#begin('~/.local/share/nvim/plugged/')
    Plug 'norcalli/nvim-colorizer.lua'
  call plug#end()
]])

require("colorizer").setup()
