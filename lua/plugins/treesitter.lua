return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"windwp/nvim-ts-autotag",
			"ThePrimeagen/refactoring.nvim",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"c",
					"cpp",
					"go",
					"lua",
					"python",
					"rust",
					"typescript",
					"tsx",
					"yaml",
					"markdown",
					"json",
					"html",
					"css",
					"javascript",
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "gnn",
						node_incremental = "grn",
						scope_incremental = "grc",
						node_decremental = "grm",
					},
				},

				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = "@class.outer",
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
						},
					},
				},
				context_commentstring = {
					enable = true,
					enable_autocmd = false,
				},
				autotag = {
					enable = true,
				},
			})

			require("refactoring").setup({})

			local map = vim.api.nvim_set_keymap
			map(
				"v",
				"<leader>rf",
				'<Esc><Cmd>lua require("refactoring").refactor("Extract Function")<CR>',
				{ noremap = true, silent = true }
			)
			map(
				"v",
				"<leader>rF",
				'<Esc><Cmd>lua require("refactoring").refactor("Extract Function to File")<CR>',
				{ noremap = true, silent = true }
			)
			map(
				"v",
				"<leader>rv",
				'<Esc><Cmd>lua require("refactoring").refactor("Extract Variable")<CR>',
				{ noremap = true, silent = true }
			)
			map(
				"v",
				"<leader>rR",
				'<Esc><Cmd>lua require("refactoring").refactor("Inline Variable")<CR>',
				{ noremap = true, silent = true }
			)
			map(
				"v",
				"<leader>rC",
				'<Esc><Cmd>lua require("refactoring").refactor("Convert To C Style")<CR>',
				{ noremap = true, silent = true }
			)
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	{
		"kylechui/nvim-surround",
		event = "BufReadPost",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"numToStr/Comment.nvim",
		keys = { "gc", "gcc", "gbc" },
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},
}
