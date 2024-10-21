require("config.keymaps")
require("config.options")
require("config.lazy")
require("plugins")
require("ebeeyuuuu")

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
