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
		"akinsho/bufferline.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		version = "*",
		config = function()
			require("bufferline").setup({
				options = {
					separator_style = "slant",
					always_show_bufferline = true,
					show_close_icon = false,
					show_buffer_close_icons = false,
					modified_icon = "+",
					close_icon = "X",
				},
				highlights = {
					background = {
						fg = "#6d6d6d",
						bg = "#101010",
					},
					buffer_selected = {
						fg = "#c2c2c2",
						bg = "#18181b",
					},
					buffer_visible = {
						fg = "#c2c2c2",
						bg = "#18181b",
					},
					separator = {
						bg = "#101010",
						fg = "#000000",
					},
					separator_selected = {
						bg = "#18181b",
						fg = "#000000",
					},
					separator_visible = {
						bg = "#18181b",
						fg = "#000000",
					},
					modified = {
						bg = "#18181b", -- background for icons in visible buffers
						fg = "#c2c2c2", -- foreground for the icon
					},
					modified_selected = {
						bg = "#18181b", -- background for icons in selected buffers
						fg = "#c2c2c2", -- foreground for the icon
					},
					modified_visible = {
						bg = "#101010", -- background for icons in non-selected buffers
						fg = "#c2c2c2", -- foreground for the icon
					},
				},
			})
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
		"rcarriga/nvim-notify",
		config = function()
			-- Configure nvim-notify
			local notify = require("notify")
			notify.setup({
				stages = "fade_in_slide_out", -- Set the notification animation
				timeout = 3000, -- Set a default timeout for notifications (3 seconds)
				max_width = 50, -- Set max width for notifications
				max_height = 10, -- Set max height for notifications
				background_colour = "#000000", -- Set background color (optional)
				icons = {
					ERROR = "", -- Customize error icon
					WARN = "", -- Customize warn icon
					INFO = "", -- Customize info icon
					DEBUG = "", -- Customize debug icon
					TRACE = "✎", -- Customize trace icon
				},
			})
		end,
		desc = "Notification system with fade in and slide out animation",
	},
}
