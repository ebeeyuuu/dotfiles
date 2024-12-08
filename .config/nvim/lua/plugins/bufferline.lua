return {
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
        },
      })
    end,
  }
}
