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
				ensure_installed = { "html", "cssls", "emmet_ls" }, -- Add your language servers here
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
		config = function()
			require("lspkind").init({
				mode = "symbol_text",
				preset = "codicons",
				symbol_map = {
					Text = "󰉿",
					Method = "󰆧",
					Function = "󰊕",
					Constructor = "",
					Field = "󰜢",
					Variable = "󰀫",
					Class = "󰠱",
					Interface = "",
					Module = "",
					Property = "󰜢",
					Unit = "󰑭",
					Value = "󰎠",
					Enum = "",
					Keyword = "󰌋",
					Snippet = "",
					Color = "󰏘",
					File = "󰈙",
					Reference = "󰈇",
					Folder = "󰉋",
					EnumMember = "",
					Constant = "󰏿",
					Struct = "󰙅",
					Event = "",
					Operator = "󰆕",
				},
			})
		end,
	},
	{
		"hrsh7th/cmp-nvim-lsp",
		dependencies = "hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			require("luasnip.loaders.from_vscode").lazy_load()

			-- Setup cmp
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					-- Tab and Shift-Tab to navigate completion menu
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),

					-- Enter to confirm the completion
					["<CR>"] = cmp.mapping.confirm({ select = true }),

					-- Escape to close completion
					["<Esc>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.close()
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" }, -- LuaSnip source
				}),
			})

			-- Automatically load snippets excluding 'uuid'
			require("luasnip.loaders.from_vscode").lazy_load({ exclude = { "uuid" } })
		end,
	},

	-- LuaSnip configuration for managing snippets
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets", -- Adds predefined snippets
		},
		config = function()
			local luasnip = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load()

			-- Define custom snippets
			luasnip.snippets = {
				all = {
					-- Other custom snippets here
				},
				typescript = {
					luasnip.snippet("clg", {
						luasnip.text_node("console.log("),
						luasnip.insert_node(1),
						luasnip.text_node(");"),
					}),
				},
				react = {
					luasnip.snippet("rfc", {
						luasnip.text_node("import React from 'react';\n\n"),
						luasnip.text_node("const "),
						luasnip.insert_node(1, "ComponentName"),
						luasnip.text_node(" = () => {\n  return (\n    <div>"),
						luasnip.insert_node(2, "Your content"),
						luasnip.text_node("</div>\n  );\n};\n\nexport default "),
						luasnip.insert_node(3, "ComponentName"),
						luasnip.text_node(";"),
					}),
				},
				javascript = {
					luasnip.snippet("fn", {
						luasnip.text_node("function "),
						luasnip.insert_node(1, "name"),
						luasnip.text_node("() {\n  "),
						luasnip.insert_node(2, "// body"),
						luasnip.text_node("\n}"),
					}),
				},
				css = {
					luasnip.snippet("bg", {
						luasnip.text_node("background: "),
						luasnip.insert_node(1, "color"),
						luasnip.text_node(";"),
					}),
				},
				html = {
					luasnip.snippet("html5", {
						luasnip.text_node("<!DOCTYPE html>\n<html>\n<head>\n  <title>"),
						luasnip.insert_node(1, "Document"),
						luasnip.text_node("</title>\n</head>\n<body>\n  "),
						luasnip.insert_node(2),
						luasnip.text_node("\n</body>\n</html>"),
					}),
				},
				lua = {
					luasnip.snippet("req", {
						luasnip.text_node("local "),
						luasnip.insert_node(1, "module"),
						luasnip.text_node(" = require('"),
						luasnip.insert_node(2, "module"),
						luasnip.text_node("')"),
					}),
				},
			}

			-- Filter out unwanted snippets like 'uuid'
			luasnip.snippets.all = vim.tbl_filter(function(snippet)
				return snippet.name ~= "uuid"
			end, luasnip.snippets.all)
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		config = function()
			-- Additional cmp configuration is in the hrsh7th/cmp-nvim-lsp setup
		end,
	},
}
