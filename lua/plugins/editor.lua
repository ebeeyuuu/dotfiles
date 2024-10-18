return {
	{
		enabled = false,
		"folke/flash.nvim",
		opts = {
			search = {
				forward = true,
				multi_window = false,
				wrap = false,
				incremental = true,
			},
		},
	},

	{
		"dinhhuy258/git.nvim",
		event = "BufReadPre",
		opts = {
			keymaps = {
				blame = "<Leader>gb",
				browse = "<Leader>go",
			},
		},
	},

	{
		"telescope.nvim",
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			"nvim-telescope/telescope-file-browser.nvim",
		},
		keys = {
			{
				"<leader>fP",
				function()
					require("telescope.builtin").find_files({
						cwd = require("lazy.core.config").options.root,
					})
				end,
				desc = "Find Plugin File",
			},
			{
				";r",
				function()
					local builtin = require("telescope.builtin")
					builtin.live_grep({
						prompt_title = "File Browser",
						additional_args = { "--hidden" },
						previewer = true,
						layout_config = {
							height = 0.8,
							width = 0.95,
							preview_cutoff = 0,
							preview_width = 0.65,
						},
						sorting_strategy = "ascending",
					})
				end,
				desc = "Search for a string in your current working directory and get results live as you type, respects .gitignore",
			},
			{
				"\\\\",
				function()
					local builtin = require("telescope.builtin")
					builtin.buffers()
				end,
				desc = "Lists open buffers",
			},
			{
				";t",
				function()
					local builtin = require("telescope.builtin")
					builtin.help_tags()
				end,
				desc = "Lists available help tags and opens a new window with the relevant help info on <cr>",
			},
			{
				";;",
				function()
					local builtin = require("telescope.builtin")
					builtin.resume()
				end,
				desc = "Resume the previous telescope picker",
			},
			{
				";e",
				function()
					local builtin = require("telescope.builtin")
					builtin.diagnostics()
				end,
				desc = "Lists Diagnostics for all open buffers or a specific buffer",
			},
			{
				";s",
				function()
					local builtin = require("telescope.builtin")
					builtin.treesitter({
						prompt_title = "Treesitter Symbols",
						layout_config = {
							height = 0.8,
							width = 0.95,
						},
						sorting_strategy = "ascending",
					})
				end,
				desc = "Lists Function names, variables, from Treesitter",
			},
			{
				"sf",
				function()
					require("telescope").extensions.file_browser.file_browser({
						path = "%:p:h",
						cwd = vim.fn.expand("%:p:h"),
						hidden = true,
						grouped = true,
						previewer = true,
						hijack_netrw = true,
						initial_mode = "insert",
						layout_strategy = "horizontal",
						prompt_position = "bottom",
						layout_config = {
							height = 0.8,
							width = 0.95,
							preview_width = 0.6,
						},
					})
				end,
				desc = "Open File Browser in the current buffer's directory and show preview",
			},
		},
		config = function(_, opts)
			local telescope = require("telescope")
			local fb_actions = require("telescope").extensions.file_browser.actions

			opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
				wrap_results = true,
				layout_strategy = "horizontal",
				layout_config = { prompt_position = "bottom" },
				sorting_strategy = "ascending",
				file_ignore_patterns = { "node_modules", "package.json" },
				prompt_prefix = " ",
				selection_caret = " ",
				path_display = { "smart" },
				mappings = {
					n = {},
				},
				winhighlight = {
					Normal = "Normal",
					Search = "None",
					TelescopeMatching = "None",
				},
			})
			opts.pickers = {
				diagnostics = {
					theme = "ivy",
					initial_mode = "insert",
					layout_config = {
						preview_cutoff = 9999,
					},
				},
			}
			opts.extensions = {
				file_browser = {
					hidden = true,
					grouped = true,
					previewer = true,
					display_stat = false,
					hijack_netrw = true,
					initial_mode = "insert",
					layout_strategy = "horizontal",
					winblend = 0,
					layout_config = {
						height = 0.8,
						width = 0.95,
						preview_width = 0.6,
					},
					mappings = {
						["n"] = {
							["N"] = fb_actions.create,
							["h"] = fb_actions.goto_parent_dir,
							["/"] = function()
								vim.cmd("startinsert")
							end,
						},
					},
				},
			}
			telescope.setup(opts)
			require("telescope").load_extension("file_browser")
		end,
	},
}
