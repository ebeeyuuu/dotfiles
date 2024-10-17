vim.api.nvim_set_keymap("n", "yy", "1GvG$y", { noremap = true, silent = true })

-- Telescope keymaps
vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Space>e", "", {
	noremap = true,
	silent = true,
	callback = function()
		local telescope = require("telescope")

		telescope.extensions.file_browser.file_browser({
			path = vim.fn.getcwd(),
			cwd = vim.fn.getcwd(),
			respect_gitignore = false,
			hidden = true,
			grouped = true,
			previewer = true,
			initial_mode = "insert",
			layout_strategy = "horizontal",
			layout_config = {
				height = 0.8,
				width = 0.95,
				preview_width = 0.6,
			},
		})
	end,
})

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
