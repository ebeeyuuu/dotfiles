return {
	{
		"laytan/cloak.nvim",
		config = function()
			require("cloak").setup({
				enabled = true,
				cloak_character = "*",
				highlight_group = "Comment",
				patterns = {
					{
						file_pattern = {
							".env*",
						},
						cloak_pattern = "=.+",
					},
				},
			})

			-- Toggle Cloak
			vim.api.nvim_set_keymap(
				"n",
				"tc", -- Leader key followed by 'tc' to toggle cloak
				[[<cmd>lua require('cloak').toggle()<CR>]],
				{ noremap = true, silent = true }
			)

			-- Check if Cloak is enabled
			vim.api.nvim_set_keymap(
				"n",
				"ce", -- Leader key followed by 'ce' to check cloak status
				[[<cmd>lua print("Cloak is " .. (require('cloak').is_enabled() and "enabled" or "disabled"))<CR>]],
				{ noremap = true, silent = true }
			)

			-- Show Cloaked patterns
			vim.api.nvim_set_keymap(
				"n",
				"cp", -- Leader key followed by 'cp' to print cloaked patterns
				[[<cmd>lua require('cloak').print_patterns()<CR>]],
				{ noremap = true, silent = true }
			)
		end,
	},
}
