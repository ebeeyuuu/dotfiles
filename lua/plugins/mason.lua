return {
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			opts.ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
				check_outdated_packages_on_open = true,
				border = 1,
				keymaps = {
					toggle_package_expand = "<CR>",
					install_package = "i",
					update_package = "u",
					check_package_version = "v",
					update_all_packages = "U",
					check_outdated_packages = "C",
					uninstall_package = "X",
					cancel_installation = "<C-c>",
				},
			}
			opts.pip = {
				upgrade_pip = true,
				install_args = {},
			}
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		opts = function(_, opts)
			opts.ensure_installed = { "lua_ls", "jsonls" }
		end,
	},
}
