vim.cmd("set termguicolors")
require("config.lazy")
require("config.options")
require("config.keymaps")

vim.cmd.colorscheme("solarized-osaka")
vim.cmd("set wrap")

local quickfile = require("util.quickfile")
quickfile.quickfile()

local bigfile = require("util.bigfile")
bigfile.bigfile()

require("telescope").setup({
  defaults = {
    file_ignore_patterns = { "node_modules" },
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
  },
  extensions = {
    file_browser = {
      hidden = true,
      grouped = true,
      previewer = true,
      hijack_netrw = true,
      display_stat = false,
      initial_mode = "insert",
      layout_strategy = "horizontal",
      layout_config = {
        height = 0.8,
        width = 0.95,
        preview_width = 0.6,
      },
    },
  },
})
