require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"bash",
		"c",
		"lua",
		"python",
		"rust",
		"go",
		"latex",
		"html",
		"css",
		"javascript",
		"vim",
		"query",
	},
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		disable = { "markdown" },
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
})

vim.keymap.set("n", "<F2>", vim.cmd.TSCaptureUnderCursor, { noremap = true })

require("treesitter-context")
