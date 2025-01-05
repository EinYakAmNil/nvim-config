return {
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({
				override = {
					nvimboat = {
						icon = "",
						color = "#666eee",
						cterm_color = "69",
						name = "Nvimboat"
					}
				}
			})
		end,
		lazy = false
	},
	{
		"nvim-lua/plenary.nvim",
		lazy = false,
	},

	--Neovim in the browser
	{
		"glacambre/firenvim",
		build = ":call firenvim#install(0)"
	},
}
