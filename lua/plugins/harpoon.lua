return {
	{
		"nvim-lua/plenary.nvim",
	},
	{
		"ThePrimeagen/harpoon",
		config = function()
			-- Set Harpoon Mark
			vim.api.nvim_set_keymap(
				"n",
				"hm",
				[[<cmd>lua require('harpoon.mark').add_file()<CR>]],
				{ noremap = true, silent = true }
			)

			vim.api.nvim_set_keymap(
				"n",
				"hr",
				[[<cmd>lua require('harpoon.mark').rm_file()<CR>]],
				{ noremap = true, silent = true }
			)

			-- Toggle Harpoon Menu
			vim.api.nvim_set_keymap(
				"n",
				"<leader>hh",
				[[<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>]],
				{ noremap = true, silent = true }
			)

			-- Navigate to File 1-4
			vim.api.nvim_set_keymap(
				"n",
				"h1",
				[[<cmd>lua require('harpoon.ui').nav_file(1)<CR>]],
				{ noremap = true, silent = true }
			)
			vim.api.nvim_set_keymap(
				"n",
				"h2",
				[[<cmd>lua require('harpoon.ui').nav_file(2)<CR>]],
				{ noremap = true, silent = true }
			)
			vim.api.nvim_set_keymap(
				"n",
				"h3",
				[[<cmd>lua require('harpoon.ui').nav_file(3)<CR>]],
				{ noremap = true, silent = true }
			)
			vim.api.nvim_set_keymap(
				"n",
				"h4",
				[[<cmd>lua require('harpoon.ui').nav_file(4)<CR>]],
				{ noremap = true, silent = true }
			)
		end,
	},
}
