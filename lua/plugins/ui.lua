return {
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		opts = function(_, opts)
			local logo = [[
███████╗██████╗ ███████╗███████╗██╗   ██╗██╗   ██╗██╗   ██╗██╗   ██╗██╗   ██╗
██╔════╝██╔══██╗██╔════╝██╔════╝╚██╗ ██╔╝██║   ██║██║   ██║██║   ██║██║   ██║
█████╗  ██████╔╝█████╗  █████╗   ╚████╔╝ ██║   ██║██║   ██║██║   ██║██║   ██║
██╔══╝  ██╔══██╗██╔══╝  ██╔══╝    ╚██╔╝  ██║   ██║██║   ██║██║   ██║██║   ██║
███████╗██████╔╝███████╗███████╗   ██║   ╚██████╔╝╚██████╔╝╚██████╔╝╚██████╔╝
╚══════╝╚═════╝ ╚══════╝╚══════╝   ╚═╝    ╚═════╝  ╚═════╝  ╚═════╝  ╚═════╝ 
      ]]

			logo = string.rep("\n", 8) .. logo .. "\n\n"
			opts.config.header = vim.split(logo, "\n")
		end,
	},
	{
		"folke/noice.nvim",
		opts = function(_, opts)
			table.insert(opts.routes, {
				filter = {
					event = "notify",
					find = "No information available",
				},
				opts = { skip = true },
			})
			local focused = true
			vim.api.nvim_create_autocmd("FocusGained", {
				callback = function()
					focused = true
				end,
			})
			vim.api.nvim_create_autocmd("FocusLost", {
				callback = function()
					focused = false
				end,
			})
			table.insert(opts.routes, 1, {
				filter = {
					cond = function()
						return not focused
					end,
				},
				view = "notify_send",
				opts = { stop = false },
			})

			opts.commands = {
				all = {
					view = "split",
					opts = { enter = true, format = "details" },
					filter = {},
				},
			}

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "markdown",
				callback = function(event)
					vim.schedule(function()
						require("noice.text.markdown").keys(event.buf)
					end)
				end,
			})

			opts.presets.lsp_doc_border = true
		end,
	},
	{
		"nanozuki/tabby.nvim",
		config = function()
			require("tabby").setup()
			vim.api.nvim_set_keymap("n", "<leader>tn", ":TabbyNewTab<CR>", { noremap = true, silent = true }) -- New Tab
			vim.api.nvim_set_keymap("n", "<leader>tc", ":TabbyCloseTab<CR>", { noremap = true, silent = true }) -- Close Tab
			vim.api.nvim_set_keymap("n", "<leader>tm", ":TabbyMoveTab<CR>", { noremap = true, silent = true }) -- Move Tab
		end,
	},
	{
		"echasnovski/mini.animate",
		event = "VeryLazy",
		opts = function(_, opts)
			opts.scroll = {
				enable = false,
			}
		end,
	},
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {
			plugins = {
				gitsigns = true,
				tmux = true,
				kitty = { enabled = false, font = "+2" },
			},
		},
		keys = { { "<leader>z", "<cmd>ZenMode<CR>", desc = "Zen Mode" } },
	},
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{ "<Tab>", "<cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
			{ "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
		},
		opts = {
			options = {
				mode = "tabs",
				separator_style = "slant",
				show_buffer_close_icons = false,
				show_close_icon = false,
			},
		},
	},
}
