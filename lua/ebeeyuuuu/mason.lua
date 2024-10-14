vim.cmd([[
  call plug#begin('~/.local/share/nvim/plugged/')
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'
  call plug#end()
]])

require("mason").setup({
	ui = {
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
	},
	pip = {
		upgrade_pip = true,
		install_args = {},
	},
})
