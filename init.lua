require("plugins.colorscheme")
require("plugins.editor")
require("config.keymaps")
require("config.options")
require("config.lazy")

vim.cmd([[
  call plug#begin('~/.local/share/nvim/plugged/')
    Plug 'neovim/nvim-lspconfig'
    Plug 'MunifTanjim/eslint.nvim'
    Plug 'nvim-tree/nvim-web-devicons'
    Plug 'kabouzeid/nvim-lspinstall'
    Plug 'jose-elias-alvarez/null-ls.nvim'
    Plug 'MunifTanjim/prettier.nvim'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'nvim-telescope/telescope-file-browser.nvim'
    Plug 'phaazon/hop.nvim'
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'mfussenegger/nvim-lint'
    Plug 'pmizio/typescript-tools.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'romgrk/barbar.nvim'
    Plug 'lewis6991/gitsigns.nvim'
  call plug#end()
]])

vim.cmd("set wrap")

local nvim_lspconfig = require("lspconfig")
nvim_lspconfig.pyright.setup({})

require("telescope").setup({
  defaults = {
    sorting_strategy = "ascending", -- You can choose "ascending" or "descending"
    file_sorter = require("telescope.sorters").get_fzy_sorter,
    file_ignore_patterns = { "node_modules", ".git/" },
    generic_sorter = require("telescope.sorters").get_fzy_sorter,
    path_display = { "absolute" },
  },
  pickers = {
    find_files = {
      sorter = require("telescope.sorters").get_fzy_sorter,
    },
  },
})
