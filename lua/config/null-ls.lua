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
          vim.lsp.buf.format({ bufnr = bufnr, async = true })
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
