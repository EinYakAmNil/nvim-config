-- Syntax highlighting
return { {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		vim.keymap.set("n", "<F2>", vim.cmd.Inspect, { noremap = true })
	end
}, {
	"nvim-treesitter/playground",
	enabled = false,
	config = function()
		vim.keymap.set("n", "<F2>", vim.cmd.TSCaptureUnderCursor, { noremap = true })
	end
}, {
	"nvim-treesitter/nvim-treesitter-context"
} }
