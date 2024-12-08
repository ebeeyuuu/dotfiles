return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 20,
      open_mapping = [[<leader>tt]],
      direction = "float",
      float_opts = {
        border = "rounded",
        width = math.floor(vim.o.columns * 0.9),
        height = math.floor(vim.o.lines * 0.8),
        winblend = 3,
      }
    })
  end
}
