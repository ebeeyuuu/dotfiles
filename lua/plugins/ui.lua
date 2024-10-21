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
	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({
				highlight = {
					keyword = "bg",
					pattern = [[.*<(KEYWORDS)\s*:]],
					colors = {
						TODO = { "DiagnosticHint", "TODO" },
						FIX = { "DiagnosticError", "ERROR" },
						NOTE = { "DiagnosticInfo", "NOTE" },
						HACK = { "DiagnosticWarning", "Warning" },
					},
				},
				search = {
					command = "rg",
					args = { "--no-heading", "--with-filename", "--line-number", "--column" },
				},
			})

			local opts = { noremap = true, silent = true }

			vim.api.nvim_set_keymap("n", "<leader>tc", "<cmd>TodoTrouble<CR>", opts) -- View todo comments in Trouble
			vim.api.nvim_set_keymap("n", "<leader>th", "<cmd>TodoHints<CR>", opts) -- View todo hints
			vim.api.nvim_set_keymap("n", "<leader>tf", "<cmd>TodoFix<CR>", opts) -- View todo fixes
			vim.api.nvim_set_keymap("n", "<leader>tn", "<cmd>TodoNotes<CR>", opts) -- View todo notes
			vim.api.nvim_set_keymap("n", "<leader>th", "<cmd>TodoHacks<CR>", opts) -- View todo hacks
			vim.api.nvim_set_keymap("n", "<leader>ts", "<cmd>TodoTelescope<CR>", opts) -- Search for todo comments using Telescope
		end,
	},
	{
		"b0o/incline.nvim",
		dependencies = { "nvim-web-devicons" },
		config = function()
			local helpers = require("incline.helpers")
			local devicons = require("nvim-web-devicons")
			require("incline").setup({
				debounce_threshold = {
					falling = 50,
					rising = 10,
				},
				hide = {
					cursorline = false,
					focused_win = false,
					only_win = false,
				},
				highlight = {
					groups = {
						InclineNormal = {
							default = true,
							group = "NormalFloat",
						},
						InclineNormalNC = {
							default = true,
							group = "NormalFloat",
						},
					},
				},
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					if filename == "" then
						filename = "[No Name]"
					end
					local ft_icon, ft_color = devicons.get_icon_color(filename)
					local modified = vim.bo[props.buf].modified
					return {
						ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
						" ",
						{ filename, gui = modified and "bold,italic" or "bold" },
						" ",
						guibg = "#1f1f1f",
						guifg = "#d1d1d1",
					}
				end,
				ignore = {
					buftypes = "special",
					filetypes = {},
					floating_wins = true,
					unlisted_buffers = true,
					wintypes = "special",
				},
				window = {
					margin = {
						horizontal = 1,
						vertical = 1,
					},
					options = {
						signcolumn = "no",
						wrap = false,
					},
					overlap = {
						borders = true,
						statusline = false,
						tabline = false,
						winbar = false,
					},
					padding = 1,
					padding_char = " ",
					placement = {
						horizontal = "right",
						vertical = "top",
					},
					width = "fit",
					winhighlight = {
						active = {
							EndOfBuffer = "None",
							Normal = "InclineNormal",
							Search = "None",
						},
						inactive = {
							EndOfBuffer = "None",
							Normal = "InclineNormalNC",
							Search = "None",
						},
					},
					zindex = 50,
				},
			})
		end,
	},
}
