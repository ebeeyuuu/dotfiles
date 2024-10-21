return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
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
