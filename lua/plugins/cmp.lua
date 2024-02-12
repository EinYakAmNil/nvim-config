return {
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require 'cmp'
			cmp.setup({
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body)
					end,
				},
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
					{ name = 'nvim_lua', keyword_length = 3, priority = 60,     max_item_count = 5 },
					{ name = 'nvim_lsp', keyword_length = 3, priority = 50,     max_item_count = 5 },
					{ name = 'luasnip' },
					{ name = 'buffer',   keyword_length = 5, max_item_count = 3 },
				}),
				experimental = {
					native_menu = false,
					ghost_text = true
				}
			})

			vim.bo.omnifunc = cmp.complete()
		end
	},
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-nvim-lua" },
	{ "hrsh7th/cmp-path" },
	{ "saadparwaiz1/cmp_luasnip" },
}
