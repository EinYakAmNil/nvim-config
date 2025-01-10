--    _   __                _
--   / | / /__  ____ _   __(_)___ ___
--  /  |/ / _ \/ __ \ | / / / __ `__ \
-- / /|  /  __/ /_/ / |/ / / / / / / /
--/_/ |_/\___/\____/|___/_/_/ /_/ /_/
--
require("theme")
require("options")
require("keymaps")

-- Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")

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
