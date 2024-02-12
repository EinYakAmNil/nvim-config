return {
	"akinsho/toggleterm.nvim",
	config = function()
		require("toggleterm").setup()

		vim.keymap.set("n", "<c-t>", "<cmd>ToggleTerm direction=float<cr>", { silent = true })
		vim.keymap.set("t", "<c-t>", "<cmd>ToggleTerm direction=float<cr>", { silent = true })
		vim.keymap.set("t", "<c-q>", "<c-\\><c-n>", { noremap = true })
	end
}
