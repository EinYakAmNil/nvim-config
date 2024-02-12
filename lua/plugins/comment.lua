return {
	"numToStr/Comment.nvim",
	config = function()
		require('Comment').setup({
			padding = true,
			sticky = true,
			ignore = '^$',
			toggler = {
				line = '<C-c>',
				block = '<leader>cb',
			},
			opleader = {
				line = '<C-c>',
				block = '<leader>cb',
			},
			extra = {
				---Add comment on the line above
				above = 'gcO',
				---Add comment on the line below
				below = 'gco',
				---Add comment at the end of line
				eol = 'gcA',
			},
			mappings = {
				basic = true,
				extra = true,
			},
		})
	end
}
