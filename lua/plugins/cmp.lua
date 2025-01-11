return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "onsails/lspkind.nvim" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
		},
		config = function()
			local lspkind = require 'lspkind'
			local cmp = require 'cmp'
			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					['<C-u>'] = cmp.mapping.scroll_docs(-4),
					['<C-d>'] = cmp.mapping.scroll_docs(4),
					['<C-e>'] = cmp.mapping.close(),
					['<C-y>'] = cmp.mapping.confirm {
						behavior = cmp.ConfirmBehavior.Insert,
						select = true
					},
					['<C-j>'] = cmp.mapping.confirm {
						behavior = cmp.ConfirmBehavior.Insert,
						select = true
					},
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lua', keyword_length = 1, priority = 60,     max_item_count = 5 },
					{ name = 'nvim_lsp', keyword_length = 1, priority = 50,     max_item_count = 5 },
					{ name = 'luasnip',  keyword_length = 3 },
					{ name = 'buffer',   keyword_length = 2, max_item_count = 3 },
				}),
				experimental = {
					native_menu = false,
					ghost_text = true
				},
				formatting = {
					format = lspkind.cmp_format({
						mode = 'symbol',
						maxwidth = 50,
						ellipsis_char = '...',
						show_labelDetails = true,
					})
				},
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body)
					end,
				},
			})

			vim.lsp.omnifunc = cmp.complete()
		end
	},
}
