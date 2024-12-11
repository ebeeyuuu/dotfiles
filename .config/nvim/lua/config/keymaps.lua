local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "yy", "01GvG$y", opts)

-- Buffer keymaps
vim.api.nvim_set_keymap("n", "BB", ":Bdelete<CR>", opts)
vim.api.nvim_set_keymap("n", "B", [[:lua vim.cmd('BufferGoto ' .. string.char(vim.fn.getchar()))<CR>]], opts)
vim.api.nvim_set_keymap("n", "BN", ":BufferLineCycleNext<CR>", opts)
vim.api.nvim_set_keymap("n", "BP", ":BufferLineCyclePrev<CR>", opts)
vim.api.nvim_set_keymap("n", "BR", ":BufferRestore<CR>", opts)

-- Split keymaps
vim.api.nvim_set_keymap("n", "sv", ":split<CR>", opts)
vim.api.nvim_set_keymap("n", "sh", ":vsplit<CR>", opts)
vim.api.nvim_set_keymap("n", "so", ":only<CR>", opts)
vim.api.nvim_set_keymap("n", "sdk", "<C-w>k", opts)
vim.api.nvim_set_keymap("n", "sdj", "<C-w>j", opts)
vim.api.nvim_set_keymap("n", "sdl", "<C-w>l", opts)
vim.api.nvim_set_keymap("n", "sdh", "<C-w>h", opts)

--Undotree keymaps
vim.api.nvim_set_keymap("n", "utf", ":UndotreeFocus<CR>", opts)
vim.api.nvim_set_keymap("n", "ut", ":UndotreeToggle<CR>", opts)

-- Other keymaps
vim.keymap.set("n", "+", "<C-a>", opts)
vim.keymap.set("n", "-", "<C-x>", opts)
vim.keymap.set("n", "dw", 'vb"_d', opts)
vim.keymap.set("n", "<C-a>", "gg<S-v>G", opts)
vim.api.nvim_set_keymap("n", "<leader>tm", ":Telescope media_files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ip", ":ImagePreviewToggle<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<space>l", ":Lazy<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>m", ":Mason<CR>", opts)

local police = require("util.police")

police.police()
