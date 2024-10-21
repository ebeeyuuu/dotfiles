return {
	{
		"jose-elias-alvarez/null-ls.nvim",
		opts = function(_, opts)
			local null_ls = require("null-ls")
			opts.sources = {
				null_ls.builtins.formatting.prettier,
			}
			opts.on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.keymap.set("n", "<Leader>f", function()
						vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
					end, { buffer = bufnr, desc = "[lsp] format" })

					local lsp_format_on_save = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = true })
					vim.api.nvim_clear_autocmds({ group = lsp_format_on_save, buffer = bufnr })

					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						group = lsp_format_on_save,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr, async = false })
							vim.cmd("write") -- Write buffer after formatting
						end,
						desc = "[lsp] format on save",
					})
				end
				if client.supports_method("textDocument/rangeFormatting") then
					vim.keymap.set("x", "<Leader>f", function()
						vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
					end, { buffer = bufnr, desc = "[lsp] format" })
				end
			end
		end,
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim", -- External tools
			"williamboman/mason-lspconfig.nvim", -- Bridge between mason and lspconfig
		},
		config = function()
			local lspconfig = require("lspconfig")
			local mason_lspconfig = require("mason-lspconfig")

			mason_lspconfig.setup({
				ensure_installed = { "tsserver", "html", "cssls", "emmet_ls" }, -- Add your language servers here
			})

			mason_lspconfig.setup_handlers({
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = vim.lsp.protocol.make_client_capabilities(),
						on_attach = function(client, bufnr)
							if client.name == "tsserver" then
								client.server_capabilities.documentFormattingProvider = false
							end
						end,
					})
				end,
			})
		end,
	},

	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"prettier",
				"typescript-language-server",
				"html-lsp",
				"css-lsp",
			},
		},
	},

	{
		"onsails/lspkind.nvim",
	},

	{
		"hrsh7th/cmp-nvim-lsp",
	},
}
