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
		"markdown_inline",
		"query",
	},
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "gnn",
			node_decremental = "gNn",
		}
	}
})

vim.keymap.set("n", "<F2>", vim.cmd.TSCaptureUnderCursor, { noremap = true })

require("treesitter-context")
