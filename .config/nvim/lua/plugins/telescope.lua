return {
  {
    "telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    keys = {
      {
        "<leader>ff",
        function()
          require("telescope.builtin").find_files({
            path = vim.fn.getcwd(),
            cwd = vim.fn.getcwd(),
            prompt_title = "Find Files",
            previewer = true,
            layout_strategy = "horizontal",
            layout_config = {
              height = 0.8,
              width = 0.95,
              preview_width = 0.65,
              preview_cutoff = 0,
            },
          })
        end,
        desc = "Find Plugin File",
      },
      {
        ";r",
        function()
          local builtin = require("telescope.builtin")
          builtin.live_grep({
            prompt_title = "Live Grep",
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
        desc =
        "Search for a string in your current working directory and get results live as you type, respects .gitignore",
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

      opts = opts or {}
      opts.defaults = opts.defaults or {}
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

      opts.pickers = opts.pickers or {}
      opts.pickers = {
        diagnostics = {
          theme = "ivy",
          initial_mode = "insert",
          layout_config = {
            preview_cutoff = 9999,
          },
        },
      }

      opts.extensions = opts.extensions or {}
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
              ["c"] = fb_actions.create,
              ["h"] = fb_actions.goto_parent_dir,
              ["/"] = function()
                vim.cmd("startinsert")
              end,
            },
          },
        },
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({
            initial_mode = "insert",
            sorting_strategy = "ascending",
            layout_strategy = "horizontal",
            layout_config = {
              prompt_position = "top",
              width = 0.8,
              height = 0.8,
            }
          })
        }
      }

      vim.cmd([[
        hi TelescopeNormal guibg=NONE guifg=#999999 ctermbg=NONE ctermfg=white
        hi TelescopeBorder guibg=NONE guifg=#616161 ctermbg=NONE ctermfg=white
        hi TelescopePromptNormal guibg=NONE guifg=#999999 ctermbg=NONE ctermfg=white
        hi TelescopePromptBorder guibg=NONE guifg=#616161 ctermbg=NONE ctermfg=white
        hi TelescopeResultsNormal guibg=NONE guifg=#999999 ctermbg=NONE ctermfg=white
        hi TelescopeResultsBorder guibg=NONE guifg=#616161 ctermbg=NONE ctermfg=white
        hi TelescopePreviewNormal guibg=NONE guifg=#999999 ctermbg=NONE ctermfg=white
        hi TelescopePreviewBorder guibg=NONE guifg=#616161 ctermbg=NONE ctermfg=white
      ]])

      telescope.setup(opts)
      require("telescope").load_extension("file_browser")
      require("telescope").load_extension("ui-select")
    end,
  },
}
