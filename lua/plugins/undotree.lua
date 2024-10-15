return {
	"mbbill/undotree",
	config = function()
		vim.keymap.set("n", "<leader>u", "UndotreeShow", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>U", "UndotreeToggle", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>r", "UndotreeFocus", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>R", "UndotreeFocusRestore", { noremap = true, silent = true })
	end,
}
