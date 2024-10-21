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

			local on_attach = function(client, bufnr)
				if client.name == "tsserver" then
					client.server_capabilities.documentFormattingProvider = false
				end

				local opts = { noremap = true, silent = true, buffer = bufnr }

				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- Go to definition
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- Go to declaration
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts) -- Go to implementation
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts) -- List references
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- Show hover information
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- Rename symbol
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts) -- Open code actions
				vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, opts) -- Open diagnostic in floating window
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- Go to previous diagnostic
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- Go to next diagnostic
			end

			mason_lspconfig.setup({
				ensure_installed = { "tsserver", "html", "cssls", "emmet_ls" }, -- Add your language servers here
			})

			mason_lspconfig.setup_handlers({
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = vim.lsp.protocol.make_client_capabilities(),
						on_attach = on_attach,
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
