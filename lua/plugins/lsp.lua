return {
	-- null-ls and formatting on save
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

	-- lsp config for TypeScript and others
	{
		"neovim/nvim-lspconfig",
		opts = function(_, opts)
			local lspconfig = require("lspconfig")

			-- tsserver configuration
			lspconfig.tsserver.setup({
				on_attach = function(client, bufnr)
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.diagnosticProvider = false
					vim.diagnostic.config({
						severity_sort = true,
						virtual_text = {
							severity = { min = vim.diagnostic.severity.WARN },
						},
					})
				end,
			})
		end,
	},

	-- lspkind for icons
	{
		"onsails/lspkind.nvim",
	},

	-- nvim-cmp for completion with LSP
	{
		"hrsh7th/cmp-nvim-lsp",
	},

	-- mason for managing external tools
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				"prettier",
				"typescript-language-server",
			})
		end,
	},
}
