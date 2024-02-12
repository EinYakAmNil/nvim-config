return {
	"nvim-neo-tree/neo-tree.nvim",
	dependencies = { "MunifTanjim/nui.nvim" },
	keys = {
		{ "<leader>f", "<cmd>Neotree filesystem reveal left<cr>", mode = "n", silent = true },
	},
	config = function()
		require('neo-tree').setup {
			filesystem = {
				filtered_items = {
					visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
					hide_dotfiles = false,
					hide_gitignored = true,
				}
			}
		}
	end
}
