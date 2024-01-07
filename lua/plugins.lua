require("lazy").setup({
	{ "nvim-lualine/lualine.nvim" },
	{ "nvim-tree/nvim-web-devicons" },
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
	-- { dir = "~/Code/nvimboat" },

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
	}
})
