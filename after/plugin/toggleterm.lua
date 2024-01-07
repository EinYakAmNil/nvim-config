require("toggleterm").setup()

vim.keymap.set("n", "<C-t>", "<cmd>ToggleTerm direction=float<CR>", { silent = true })
vim.keymap.set("t", "<C-t>", "<cmd>ToggleTerm direction=float<CR>", { silent = true })
vim.keymap.set("t", "<C-q>", "<C-\\><C-n>", { noremap = true })
