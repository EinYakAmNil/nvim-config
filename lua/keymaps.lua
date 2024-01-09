vim.keymap.set("", "<space>", ":", { noremap = true })
vim.keymap.set("", "<cr>", "/", { noremap = true })

--window mainpulation
vim.keymap.set("n", "+", "<c-w>+", { noremap = true })
vim.keymap.set("n", "-", "<c-w>-", { noremap = true })
vim.keymap.set("n", "<", "<c-w><", { noremap = true })
vim.keymap.set("n", ">", "<c-w>>", { noremap = true })
vim.keymap.set("n", "J", "<cmd>tabprevious<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "K", "<cmd>tabnext<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "H", "Hk", { noremap = true, silent = true })
vim.keymap.set("n", "L", "Lj", { noremap = true, silent = true })
vim.keymap.set("n", "<c-h>", "<c-w>h", { noremap = true })
vim.keymap.set("n", "<c-j>", "<c-w>j", { noremap = true })
vim.keymap.set("n", "<c-k>", "<c-w>k", { noremap = true })
vim.keymap.set("n", "<c-l>", "<c-w>l", { noremap = true })
vim.keymap.set("n", "<c-d>", "<c-d>zz", { noremap = true })
vim.keymap.set("n", "<c-u>", "<c-u>zz", { noremap = true })
vim.keymap.set("n", "n", "nzzzv", { noremap = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true })
vim.keymap.set("n", "G", "Gzz", { noremap = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = vim.api.nvim_create_augroup("keymaps", { clear = true }),
	pattern = { "help" },
	callback = function()
		vim.cmd.wincmd("L")
	end
})

-- buffer mainpulation
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")

vim.keymap.set("v", "<leader>+", '"+y', { noremap = true })
vim.keymap.set("", "<leader><cr>", "/\\c", { noremap = true }) --ignore case search
vim.keymap.set("", "<leader>p", "\"_dP", { noremap = true }) --better pasting
vim.keymap.set("n", "<leader>s", [[:%s/\<<c-r><c-w>\>/<c-r><c-w>/gI<left><left><left>]])
