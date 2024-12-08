return {
  {
    "laytan/cloak.nvim",
    config = function()
      require("cloak").setup({
        enabled = true,
        cloak_character = "*",
        highlight_group = "Comment",
        patterns = {
          {
            file_pattern = {
              ".env*",
            },
            cloak_pattern = "=.+",
          },
        },
      })

      vim.api.nvim_set_keymap("n", "tc", [[<cmd>lua require('cloak').toggle()<CR>]], { noremap = true, silent = true })

      vim.api.nvim_set_keymap(
        "n",
        "ce",
        [[<cmd>lua print("Cloak is " .. (require('cloak').is_enabled() and "enabled" or "disabled"))<CR>]],
        { noremap = true, silent = true }
      )

      vim.api.nvim_set_keymap(
        "n",
        "cp",
        [[<cmd>lua require('cloak').print_patterns()<CR>]],
        { noremap = true, silent = true }
      )
    end,
  },
}
