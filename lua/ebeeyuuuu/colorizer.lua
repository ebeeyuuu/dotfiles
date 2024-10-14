vim.cmd([[
  call plug#begin('~/.local/share/nvim/plugged/')
    Plug 'norcalli/nvim-colorizer.lua'
  call plug#end()
]])

require("colorizer").setup({
	"css",
	"javascript",
	html = {
		mode = "background",
	},
})

vim.keymap.set("n", "<leader>cfb", ":ColorizerDetachFromBuffer<CR>")
vim.keymap.set("n", "<leader>crb", ":ColorizerReloadAllBuffers<CR>")
vim.keymap.set("n", "<leader>ct", ":ColorizerToggle<CR>")
