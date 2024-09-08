require("kanagawa").setup({
  transparent = true,
  dimInactive = false,
  colors = {
    theme = {
      all = {
        ui = { bg_gutter = "NONE" },
      },
    },
  },
})

-- Apply the colorscheme
vim.cmd("colorscheme kanagawa-dragon")

-- Make specific highlight groups transparent
local hl_groups = {
  "Normal",
  "NormalNC",
  "NormalFloat",
  "LineNr",
  "SignColumn",
  "CursorLine",
  "CursorLineNr",
  "StatusLine",
  "StatusLineNC",
}

for _, group in ipairs(hl_groups) do
  vim.api.nvim_set_hl(0, group, { bg = "NONE" })
end
