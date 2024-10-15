return {
	"pmizio/typescript-tools.nvim",
	config = function()
		require("typescript-tools").setup({
			settings = {
				separate_diagnostic_server = true,
				publish_diagnostic_on = "insert_leave",
				expose_as_code_action = { "fix_all", "add_missing_imports", "remove_unused" },
				tsserver_path = nil,
				tsserver_plugins = {},
				tsserver_max_memory = "auto",
				tesserver_format_options = {},
				tsserver_file_preferences = {},
				tsserver_locale = "en",
				complete_function_calls = true,
				include_completions_with_insert_text = true,
				code_lens = "all",
				disable_member_code_lens = true,
				jsx_close_tag = {
					enable = false,
					filetypes = { "javascriptreact", "typescriptreact" },
				},
			},
		})
	end,
}
