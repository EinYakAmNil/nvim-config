require("lualine").setup({
	options = {
		theme = package.loaded.yak.lualine,
		section_separators = { left = "", right = " " },
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
			"branch",
			{
				"diff",
				diff_color = {
					removed = { fg = 52 },
				},
			},
			{
				"diagnostics",
				diagnostics_color = {
					error = { fg = 52 },
				},
			},
		},
		lualine_c = { "filename" },
		lualine_x = {
			{
				"filetype",
				colored = true,
				icon_only = false,
			},
		},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = { "branch" },
		lualine_b = { "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})

vim.g.firenvim_config = {
	localSettings = {
		[".*"] = {
			cmdline = "neovim",
			content = "text",
			priority = 0,
			selector = "textarea",
			takeover = "never",
		},
	},
}

if vim.g.started_by_firenvim then
	vim.opt.laststatus = 0
else
	vim.o.laststatus = 3
end
