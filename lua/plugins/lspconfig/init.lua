local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.opt.signcolumn = "yes"

return {
	"neovim/nvim-lspconfig",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	event = "FileType",
	config = function()
		local lspconfig = require("lspconfig")
		local utils = require("plugins.lspconfig.utils")
		local c_settings = require("plugins.lspconfig.c")
		local go_settings = require("plugins.lspconfig.go")
		local javascript_settings = require("plugins.lspconfig.javascript")
		local latex_settings = require("plugins.lspconfig.latex")
		local lua_settings = require("plugins.lspconfig.lua")
		local python_settings = require("plugins.lspconfig.python")
		lspconfig.ccls.setup({
			capabilities = capabilities,
			on_attach = function()
				utils.on_attach(c_settings)
			end
		})
		lspconfig.pylsp.setup({
			capabilities = capabilities,
			on_attach = function()
				utils.on_attach(python_settings)
			end,
		})
		lspconfig.gopls.setup({
			capabilities = capabilities,
			on_attach = function()
				utils.on_attach(go_settings)
			end
		})
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			on_attach = function()
				utils.on_attach(lua_settings)
			end,
			settings = {
				Lua = {
					diagnostics = {
						disable = { "lowercase-global" },
					},
				},
			},
		})
		lspconfig.texlab.setup({
			capabilities = capabilities,
			on_attach = function()
				utils.on_attach(latex_settings)
			end
		})
		lspconfig.ts_ls.setup({
			capabilities = capabilities,
			on_attach = function()
				utils.on_attach(javascript_settings)
			end
		})
	end
}
