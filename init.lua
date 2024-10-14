require("plugins.colorscheme")
require("plugins.editor")

require("config.keymaps")
require("config.options")
require("config.lazy")

require("ebeeyuuuu")

vim.cmd([[
  call plug#begin('~/.local/share/nvim/plugged/')
    Plug 'neovim/nvim-lspconfig'
    Plug 'MunifTanjim/eslint.nvim'
    Plug 'nvim-tree/nvim-web-devicons'
    Plug 'kabouzeid/nvim-lspinstall'
    Plug 'jose-elias-alvarez/null-ls.nvim'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'phaazon/hop.nvim'
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'mfussenegger/nvim-lint'
    Plug 'pmizio/typescript-tools.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'romgrk/barbar.nvim'
    Plug 'lewis6991/gitsigns.nvim'
    Plug 'onsails/lspkind.nvim'
    Plug 'folke/lazydev.nvim'
    Plug 'echasnovski/mini.nvim'
    Plug 'mbbill/undotree'
    Plug 'David-Kunz/gen.nvim'
    Plug 'supermaven-inc/supermaven-nvim'
    Plug 'norcalli/nvim-colorizer.lua'
  call plug#end()
]])

vim.cmd("set wrap")

vim.diagnostic.config({
	virtual_text = false,
	signs = false,
	update_in_insert = false,
})

require("colorizer").setup()
