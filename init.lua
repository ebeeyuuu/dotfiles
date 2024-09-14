require("plugins.colorscheme")
require("plugins.editor")
require("config.keymaps")
require("config.options")
require("config.lazy")

vim.cmd([[
  call plug#begin('~/.local/share/nvim/plugged/')
    Plug 'neovim/nvim-lspconfig'
    Plug 'MunifTanjim/eslint.nvim'
    Plug 'nvim-tree/nvim-web-devicons'
    Plug 'kabouzeid/nvim-lspinstall'
    Plug 'jose-elias-alvarez/null-ls.nvim'
    Plug 'MunifTanjim/prettier.nvim'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'nvim-telescope/telescope-file-browser.nvim'
    Plug 'phaazon/hop.nvim'
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'mfussenegger/nvim-lint'
    Plug 'pmizio/typescript-tools.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'romgrk/barbar.nvim'
    Plug 'lewis6991/gitsigns.nvim'
    Plug 'onsails/lspkind.nvim'
    Plug 'folke/lazydev.nvim'
    Plug 'echasnovski/mini.nvim'
    Plug 'laytan/cloak.nvim'
  call plug#end()
]])

vim.cmd("set wrap")

local nvim_lspconfig = require("lspconfig")
nvim_lspconfig.pyright.setup({})

require("telescope").setup({
  defaults = {
    sorting_strategy = "ascending", -- You can choose "ascending" or "descending"
    file_sorter = require("telescope.sorters").get_fzy_sorter,
    file_ignore_patterns = { "node_modules", ".git/" },
    generic_sorter = require("telescope.sorters").get_fzy_sorter,
    path_display = { "absolute" },
  },
  pickers = {
    find_files = {
      sorter = require("telescope.sorters").get_fzy_sorter,
    },
  },
})

local null_ls = require("null-ls")
local lsp_format_on_save = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = true })

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettier,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.keymap.set("n", "<Leader>f", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })

      vim.api.nvim_clear_autocmds({ group = lsp_format_on_save, buffer = bufnr })

      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        group = lsp_format_on_save,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, async = false }) -- Format buffer
          vim.cmd("write") -- Write the buffer after formatting
        end,
        desc = "[lsp] format on save",
      })
    end

    if client.supports_method("textDocument/rangeFormatting") then
      vim.keymap.set("x", "<Leader>f", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })
    end
  end,
})

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },
  sections = {
    lualine_a = {
      {
        "mode",
        icons_enabled = true,
        show_filename_only = true,
        hide_filename_extension = false,
        show_modified_status = true,
        mode = 2,
        symbols = {
          modified = "[+]",
          alternate_file = "#",
          directory = "",
        },
      },
    },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = {
      {
        "filename",
        symbols = {
          readonly = "[🔒]",
        },
      },
    },
    lualine_x = {
      "encoding",
      "fileformat",
      "filetype",
      {
        "diagnostics",
        sources = { "nvim_diagnostics" },
        symbols = { error = "🆇 ", warn = "⚠️ ", info = "ℹ️ ", hint = " " },
      },
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
})

local prettier = require("prettier")

prettier.setup({
  bin = "prettier", -- or `'prettierd'` (v0.23.3+)
  filetypes = {
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "less",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
  },
  cli_options = {
    arrow_parens = "always",
    bracket_spacing = true,
    bracket_same_line = false,
    embedded_language_formatting = "auto",
    end_of_line = "lf",
    html_whitespace_sensitivity = "css",
    jsx_single_quote = false,
    print_width = 80,
    prose_wrap = "preserve",
    quote_props = "as-needed",
    semi = true,
    single_attribute_per_line = false,
    single_quote = false,
    tab_width = 2,
    trailing_comma = "es5",
    use_tabs = false,
    vue_indent_script_and_style = false,
  },
})

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
