require("lazy").setup({
	{
		"nvim-lualine/lualine.nvim",
		cond = function()
			if vim.g.started_by_firenvim then
				vim.opt.laststatus = 0
				return false
			else
				vim.o.laststatus = 3
				return true
			end
		end,
	},
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
	{ "NvChad/nvim-colorizer.lua" },
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-telescope/telescope.nvim" },
	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-nvim-lua" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/nvim-cmp" },
	{ "L3MON4D3/LuaSnip" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "numToStr/Comment.nvim" },

	-- Automatic brackets.
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {}
	},

	-- Syntax highlighting
	{ "nvim-treesitter/nvim-treesitter" },
	{ "nvim-treesitter/nvim-treesitter-context" },
	{ "nvim-treesitter/playground" },

	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
	},
	{ "akinsho/toggleterm.nvim" },

	--Neovim in the browser
	{
		"glacambre/firenvim",
		build = function()
			vim.fn["firenvim#install"](0)
		end,
	},

	{ dir = "~/Projekte/nvimboat" },
})
