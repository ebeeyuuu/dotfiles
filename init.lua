require("plugins.colorscheme")
require("plugins.editor")
require("plugins.mason")
require("plugins.lsp")
require("plugins.prettier")
require("plugins.supermaven")
require("plugins.typescripttools")

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
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'mfussenegger/nvim-lint'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'romgrk/barbar.nvim'
    Plug 'lewis6991/gitsigns.nvim'
    Plug 'onsails/lspkind.nvim'
    Plug 'folke/lazydev.nvim'
    Plug 'echasnovski/mini.nvim'
    Plug 'laytan/cloak.nvim'
    Plug 'mbbill/undotree'
    Plug 'David-Kunz/gen.nvim'
    Plug 'supermaven-inc/supermaven-nvim'
    Plug 'nanozuki/tabby.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-file-browser.nvim'
  call plug#end()
]])

require("telescope").setup({
	extensions = {
		file_browser = {
			hidden = true,
			grouped = true,
			previewer = true,
			initial_mode = "normal",
			layout_strategy = "horizontal",
			layout_config = {
				height = 0.8,
				width = 0.95,
				preview_width = 0.6,
			},
		},
	},
})

require("telescope").load_extension("file_browser")
require("tabby").setup({})

vim.cmd("set wrap")
