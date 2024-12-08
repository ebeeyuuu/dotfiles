local M = {}

local defaults = {
  notify = true,
  size = 1.5 * 1024 * 1024,
  --@param ctx {buf: number, ft: string}
  setup = function(ctx)
    vim.cmd([[NoMatchParen]])
    vim.wo.foldmethod = "manual"
    vim.wo.statuscolumn = ""
    vim.wo.conceallevel = 0

    vim.schedule(function()
      vim.bo[ctx.buf].syntax = ctx.ft
    end)
  end,
}

function M.bigfile()
  local opts = vim.tbl_deep_extend("force", defaults, vim.g.bigfile_config or {})

  vim.filetype.add({
    pattern = {
      [".*"] = function(path, buf)
        return vim.bo[buf]
            and vim.bo[buf].filetype ~= "bigfile"
            and path
            and vim.fn.getfsize(path) > opts.size
            and "bigfile"
            or nil
      end,
    },
  })

  vim.api.nvim_create_autocmd({ "FileType" }, {
    group = vim.api.nvim_create_augroup("bigfile_plugin", { clear = true }),
    pattern = "bigfile",
    callback = function(ev)
      if opts.notify then
        local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(ev.buf), ":p:~:.")
        vim.notify(
          ("Big file detected '%s'. Some Neovim features have been disabled."):format(path),
          vim.log.levels.WARN,
          { title = "Big File" }
        )
      end

      vim.api.nvim_buf_call(ev.buf, function()
        opts.setup({
          buf = ev.buf,
          ft = vim.filetype.match({ buf = ev.buf }) or "",
        })
      end)
    end
  })
end

return M
