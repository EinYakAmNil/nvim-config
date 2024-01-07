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
