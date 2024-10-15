vim.api.nvim_set_keymap("n", "yy", "1GvG$y", { noremap = true, silent = true })

-- Telescope keymaps
vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Space>e", ":Telescope file_browser<cr>", { noremap = true, silent = true })

require("telescope").setup({
	defaults = {
		layout_strategy = "horizontal",
		layout_config = {
			prompt_position = "top", -- Prompt (input box) at the top
			preview_width = 0.55, -- Adjust preview width (55% for preview, 45% for file list)
			width = 0.8, -- Overall width (80% of the window width)
			height = 0.9, -- Overall height (90% of the window height)
		},
		sorting_strategy = "ascending",
		wrap_results = true, -- Wrapping search results if too long
	},
	pickers = {
		find_files = {
			hidden = true, -- Shows hidden files
			layout_config = {
				preview_cutoff = 120, -- Show preview on the right side for wider layouts
			},
		},
	},
	extensions = {
		file_browser = {
			theme = "dropdown",
			hijack_netrw = true,
			mappings = {
				["n"] = {
					["N"] = require("telescope").extensions.file_browser.actions.create, -- Create new file/directory
					["h"] = require("telescope").extensions.file_browser.actions.goto_parent_dir, -- Go up a directory
				},
			},
			layout_config = {
				prompt_position = "top", -- Place the directory listing at the top
				preview_width = 0.55, -- Set preview width (adjust as needed)
			},
		},
	},
})

require("telescope").load_extension("file_browser")

-- Buffer keymaps
vim.api.nvim_set_keymap("n", "BB", ":BufferClose<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
	"n",
	"B",
	[[:lua vim.cmd('BufferGoto ' .. string.char(vim.fn.getchar()))<CR>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "BL", ":BufferNext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "BJ", ":BufferPrevious<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "BR", ":BufferRestore<CR>", { noremap = true, silent = true })
