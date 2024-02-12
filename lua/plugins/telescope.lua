return {
	"nvim-telescope/telescope.nvim",
	config = function()
		local builtin = require("telescope.builtin")
		local mapopts = { noremap = true, silent = true }

		vim.keymap.set("n", "<C-n>", function()
			vim.cmd.tabnew()
			builtin.find_files()
		end, mapopts)
		vim.keymap.set("n", "<C-e>", function()
			builtin.find_files()
		end, mapopts)
		vim.keymap.set("n", "<leader>g", function()
			vim.cmd.tabnew()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end, mapopts)
		vim.keymap.set("n", "<F1>", builtin.help_tags, mapopts)
	end
}
