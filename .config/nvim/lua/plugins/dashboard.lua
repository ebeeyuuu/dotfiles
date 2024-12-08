return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    config = function()
      local logo = [[
  ███████╗██████╗ ███████╗███████╗██╗   ██╗██╗   ██╗██╗   ██╗██╗   ██╗██╗   ██╗
  ██╔════╝██╔══██╗██╔════╝██╔════╝╚██╗ ██╔╝██║   ██║██║   ██║██║   ██║██║   ██║
  █████╗  ██████╔╝█████╗  █████╗   ╚████╔╝ ██║   ██║██║   ██║██║   ██║██║   ██║
  ██╔══╝  ██╔══██╗██╔══╝  ██╔══╝    ╚██╔╝  ██║   ██║██║   ██║██║   ██║██║   ██║
  ███████╗██████╔╝███████╗███████╗   ██║   ╚██████╔╝╚██████╔╝╚██████╔╝╚██████╔╝
  ╚══════╝╚═════╝ ╚══════╝╚══════╝   ╚═╝    ╚═════╝  ╚═════╝  ╚═════╝  ╚═════╝
        ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"

      local telescope_defaults = {
        previewer = true,
        layout_strategy = "horizontal",
        layout_config = {
          height = 0.8,
          width = 0.95,
          preview_width = 0.65,
          preview_cutoff = 0,
        },
        sorting_strategy = "ascending",
      }

      local builtin = require("telescope.builtin")

      local function find_files()
        builtin.find_files(vim.tbl_extend("force", telescope_defaults, {
          cwd = vim.fn.getcwd(),
          prompt_title = "Find Files",
        }))
      end

      local function find_text()
        builtin.live_grep(vim.tbl_extend("force", telescope_defaults, {
          cwd = vim.fn.getcwd(),
          prompt_title = "Find Text",
        }))
      end

      local function recent_files()
        builtin.oldfiles(vim.tbl_extend("force", telescope_defaults, {
          prompt_title = "Recent Files",
        }))
      end

      local function config_files()
        builtin.find_files(vim.tbl_extend("force", telescope_defaults, {
          cwd = vim.fn.stdpath("config"),
          prompt_title = "Config Files",
        }))
      end

      require("dashboard").setup {
        theme = "doom",
        config = {
          header = vim.split(logo, "\n"),
          center = {
            {
              icon = " ",
              icon_hl = "Title",
              desc = "Find File                         ",
              desc_hl = "String",
              key = "f",
              key_hl = "Number",
              key_format = " %s",
              action = find_files,
            },
            {
              icon = " ",
              icon_hl = "Title",
              desc = "New File                         ",
              desc_hl = "String",
              key = "n",
              key_hl = "Number",
              key_format = " %s",
              action = ":ene | startinsert"
            },
            {
              icon = " ",
              icon_hl = "Title",
              desc = "Find Text                         ",
              desc_hl = "String",
              key = "g",
              key_hl = "Number",
              key_format = " %s",
              action = find_text,
            },
            {
              icon = " ",
              icon_hl = "Title",
              desc = "Recent Files                         ",
              desc_hl = "String",
              key = "r",
              key_hl = "Number",
              key_format = " %s",
              action = recent_files,
            },
            {
              icon = " ",
              icon_hl = "Title",
              desc = "Config                         ",
              desc_hl = "String",
              key = "c",
              key_hl = "Number",
              key_format = " %s",
              action = config_files,
            },
            {
              icon = " ",
              icon_hl = "Title",
              desc = "Restore Session                         ",
              desc_hl = "String",
              key = "s",
              key_hl = "Number",
              key_format = " %s",
              action = ":source Session.vim"
            },
            {
              icon = "󰒲 ",
              icon_hl = "Title",
              desc = "Lazy                         ",
              desc_hl = "String",
              key = "L",
              key_hl = "Number",
              key_format = " %s",
              action = ":Lazy"
            },
            {
              icon = " ",
              icon_hl = "Title",
              desc = "Quit                         ",
              desc_hl = "String",
              key = "q",
              key_hl = "Number",
              key_format = " %s",
              action = ":qa"
            },
          },
          footer = {
            "",
            "To be successful,",
            "you need to be willing to outwork everyone else.",
            "Do what they won't do. See what they don't see.",
            "Just do it."
          },
        },
      }
    end,
  },
}
