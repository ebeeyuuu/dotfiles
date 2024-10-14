vim.cmd([[
  call plug#begin('~/.local/share/nvim/plugged/')
    Plug 'laytan/cloak.nvim'
  call plug#end()
]])

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
