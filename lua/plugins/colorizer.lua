return {
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()

			-- Toggle Colorizer
			vim.api.nvim_set_keymap(
				"n",
				"TC", -- Leader key followed by 'tc' to toggle colorizer
				[[<cmd>ColorizerToggle<CR>]],
				{ noremap = true, silent = true }
			)

			-- Attach colorizer to current buffer
			vim.api.nvim_set_keymap(
				"n",
				"ac", -- Leader key followed by 'ac' to attach colorizer
				[[<cmd>ColorizerAttachToBuffer<CR>]],
				{ noremap = true, silent = true }
			)

			-- Detach colorizer from current buffer
			vim.api.nvim_set_keymap(
				"n",
				"dc", -- Leader key followed by 'dc' to detach colorizer
				[[<cmd>ColorizerDetachFromBuffer<CR>]],
				{ noremap = true, silent = true }
			)
		end,
	},
}
