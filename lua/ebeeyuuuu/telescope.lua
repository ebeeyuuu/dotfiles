vim.cmd([[
  call plug#begin('~/.local/share/nvim/plugged/')
    Plug 'nvim-telescope/telescope-file-browser.nvim'
  call plug#end()
]])

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
