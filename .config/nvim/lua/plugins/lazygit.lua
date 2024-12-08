return {
  "kdheepak/lazygit.nvim",
  lazy = false,
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  keys = {
    { "<leader>gg", ":LazyGit<CR>",                  desc = "Open LazyGit" },
    { "<leader>gb", ":LazyGitFilterCurrentFile<CR>", desc = "Blame Current File" },
    { "<leader>gs", ":LazyGitFilter<CR>",            desc = "Show File History" },
    { "<leader>gl", "<cmd>Telescope lazygit<CR>",    desc = "Telescope LazyGit" },
  },
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local function is_lazygit_available()
      return vim.fn.executable("lazygit") == 1
    end

    if not is_lazygit_available() then
      vim.notify("LazyGit is not installed or not in PATH", vim.log.levels.WARN)
      return
    end

    vim.g.lazygit_floating_window_winblend = 0
    vim.g.lazygit_floating_window_scaling_factor = 0.8
    vim.g.lazygit_use_neovim_remote = 1

    vim.api.nvim_set_keymap("n", "<leader>gq", ":LazyGitClose<CR>",
      { noremap = true, silent = true, desc = "Close LazyGit" })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "lazygit",
      callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
      end,
    })

    require("telescope").load_extension("lazygit")
  end,
  event = "VeryLazy",
}
