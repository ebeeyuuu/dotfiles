local M = {}

--@class QuickFile
local defaults = {
  exclude = { "latex" },
}

function M.quickfile()
  local opts = defaults

  if vim.v.vim_did_enter == 1 then
    return
  end

  local buf = vim.api.nvim_get_current_buf()

  local ft = vim.filetype.match({ buf = buf })
  if ft then
    local lang = vim.treesitter.language.get_lang(ft)

    if vim.tbl_contains(opts.exclude, lang) then
      lang = nil
    end

    if not (lang and pcall(vim.treesitter.start, buf, lang)) then
      vim.bo[buf].syntax = ft
    end

    vim.cmd([[redraw]])
  end
end

return M
