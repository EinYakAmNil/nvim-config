local treesitter = vim.api.nvim_create_augroup('treesitter', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
	group = treesitter,
	pattern = {
		"ansible",
		"bash",
		"c",
		"go",
		"lua",
		"nvimboat",
		"sh",
		"sql",
		"yaml",
		"zsh",
		"json",
	},
	callback = function()
		vim.treesitter.start()
	end
})

vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.wo.foldmethod = 'expr'
