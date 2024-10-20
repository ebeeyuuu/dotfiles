require("plugins.colorscheme")
require("plugins.ui")
require("plugins.cloak")
require("plugins.editor")
require("plugins.mason")
require("plugins.lsp")
require("plugins.prettier")
require("plugins.supermaven")
require("plugins.typescripttools")

require("config.keymaps")
require("config.options")
require("config.lazy")

local discipline = require("ebeeyuuuu.discipline")
discipline.discipline()

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
    Plug 'akinsho/bufferline.nvim'
    Plug 'nvim-telescope/telescope-file-browser.nvim'
  call plug#end()
]])

vim.cmd([[
  hi Normal guibg=NONE ctermbg=NONE
  hi TelescopeNormal guibg=NONE ctermbg=NONE
  hi TelescopeBorder guibg=NONE ctermbg=NONE
  hi TelescopePromptNormal guibg=NONE ctermbg=NONE
  hi TelescopePromptBorder guibg=NONE ctermbg=NONE
  hi TelescopeResultsNormal guibg=NONE ctermbg=NONE
  hi TelescopeResultsBorder guibg=NONE ctermbg=NONE
  hi TelescopePreviewNormal guibg=NONE ctermbg=NONE
  hi TelescopePreviewBorder guibg=NONE ctermbg=NONE
]])

require("telescope").setup({
	defaults = {
		file_ignore_patterns = { "node_modules", "package.json" },
		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "smart" },
	},
	extensions = {
		file_browser = {
			hidden = true,
			grouped = true,
			previewer = true,
			hijack_netrw = true,
			display_stat = false,
			initial_mode = "insert",
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
vim.cmd("set wrap")
