vim.cmd([[
  call plug#begin('~/.local/share/nvim/plugged/')
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'onsails/lspkind.nvim'
    Plug 'jose-elias-alvarez/null-ls.nvim'
  call plug#end()
]])

local lspconfig = require("lspconfig")
local null_ls = require("null-ls")
local lsp_format_on_save = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = true })

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.prettier,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.keymap.set("n", "<Leader>f", function()
				vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
			end, { buffer = bufnr, desc = "[lsp] format" })

			vim.api.nvim_clear_autocmds({ group = lsp_format_on_save, buffer = bufnr })

			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = bufnr,
				group = lsp_format_on_save,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr, async = false }) -- Format buffer
					vim.cmd("write") -- Write the buffer after formatting
				end,
				desc = "[lsp] format on save",
			})
		end

		if client.supports_method("textDocument/rangeFormatting") then
			vim.keymap.set("x", "<Leader>f", function()
				vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
			end, { buffer = bufnr, desc = "[lsp] format" })
		end
	end,
})

lspconfig.tsserver.setup({
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.diagnosticProvider = false
		vim.diagnostic.config({
			severity_sort = true,
			virtual_text = {
				severity = { min = vim.diagnosticl.severity.WARN },
			},
		})
	end,
})
