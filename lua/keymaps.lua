vim.keymap.set("", "<Space>", ":", { noremap = true })
vim.keymap.set("", "<CR>", "/", { noremap = true })

--window mainpulation
vim.keymap.set("n", "+", "<C-w>+", { noremap = true })
vim.keymap.set("n", "-", "<C-w>-", { noremap = true })
vim.keymap.set("n", "<", "<C-w><", { noremap = true })
vim.keymap.set("n", ">", "<C-w>>", { noremap = true })
vim.keymap.set("n", "J", "<CMD>tabprevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "K", "<CMD>tabnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "H", "Hk", { noremap = true, silent = true })
vim.keymap.set("n", "L", "Lj", { noremap = true, silent = true })
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })
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
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("v", "<leader>+", '"+y', { noremap = true })
vim.keymap.set("", "<leader><CR>", "/\\c", { noremap = true }) --ignore case search
vim.keymap.set("", "<leader>p", "\"_dP", { noremap = true }) --better pasting
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
