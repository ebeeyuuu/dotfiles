return {
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
      vim.api.nvim_set_keymap("n", "<leader>th", "<cmd>TodoHints<CR>", opts)  -- View todo hints
      vim.api.nvim_set_keymap("n", "<leader>tf", "<cmd>TodoFix<CR>", opts)    -- View todo fixes
      vim.api.nvim_set_keymap("n", "<leader>tn", "<cmd>TodoNotes<CR>", opts)  -- View todo notes
      vim.api.nvim_set_keymap("n", "<leader>th", "<cmd>TodoHacks<CR>", opts)  -- View todo hacks
      vim.api.nvim_set_keymap("n", "<leader>ts", "<cmd>TodoTelescope<CR>", opts) -- Search for todo comments using Telescope
    end,
  },
}
