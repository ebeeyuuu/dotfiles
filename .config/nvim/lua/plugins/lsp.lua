return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lsp = require('lspconfig')
      require("mason").setup({})
      require("mason-lspconfig").setup({
        ensure_installed = { "cssls", "cssmodules_ls", "tailwindcss", "html", "eslint", "ts_ls", "lua_ls", "pyright", }
      })

      local on_attach = function(client, bufnr)
        local bufopts = { noremap = true, silent = true, buffer = bufnr }

        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', 'HK', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

        if client.supports_method("textDocument/formatting") then
          vim.keymap.set("n", "<Leader>f", function()
            vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
          end, { buffer = bufnr, desc = "[lsp] format" })

          local lsp_format_on_save = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = true })
          vim.api.nvim_clear_autocmds({ group = lsp_format_on_save, buffer = bufnr })

          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            group = lsp_format_on_save,
            callback = function()
              print("Formatting before saving...")
              vim.lsp.buf.format({ bufnr = bufnr, async = false })
              vim.cmd("write")
            end,
            desc = "[lsp] format on save",
          })
        end
        if client.supports_method("textDocument/rangeFormatting") then
          vim.keymap.set("x", "<Leader>f", function()
            vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
          end, { buffer = bufnr, desc = "[lsp] format" })
        end
      end

      lsp.html.setup { on_attach = on_attach }
      lsp.cssls.setup { on_attach = on_attach }
      lsp.ts_ls.setup { on_attach = on_attach }
      lsp.eslint.setup { on_attach = on_attach }
      lsp.pyright.setup { on_attach = on_attach }
      lsp.tailwindcss.setup { on_attach = on_attach }
      lsp.lua_ls.setup {
        on_attach = on_attach,
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
              path = vim.split(package.path, ';'),
            },
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file('', true),
            },
            telemetry = {
              enable = false,
            },
          },
        },
      }
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local null_ls = require("null-ls")
      opts.sources = {
        null_ls.builtins.formatting.prettier,
      }
      opts.on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.keymap.set("n", "<Leader>f", function()
            vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
          end, { buffer = bufnr, desc = "[lsp] format" })

          local lsp_format_on_save = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = true })
          vim.api.nvim_clear_autocmds({ group = lsp_format_on_save, buffer = bufnr })

          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            group = lsp_format_on_save,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr, async = false })
              vim.cmd("write") -- Write buffer after formatting
            end,
            desc = "[lsp] format on save",
          })
        end
        if client.supports_method("textDocument/rangeFormatting") then
          vim.keymap.set("x", "<Leader>f", function()
            vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
          end, { buffer = bufnr, desc = "[lsp] format" })
        end
      end
    end,
  },
}
