local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.api.nvim_create_augroup("ansiblels", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = "ansiblels",
	pattern = "yaml",
	callback = function(ev)
		local path = vim.fs.dirname(ev.file)
		if path and string.find(path, "/ansible") then
			vim.bo.filetype = "yaml.ansible"
			return
		end
		path = vim.fn.getcwd()
		if path and string.find(path, "/ansible") then
			vim.bo.filetype = "yaml.ansible"
			return
		end
	end,
})

vim.opt.signcolumn = "yes"

return {
	"neovim/nvim-lspconfig",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	event = "FileType",
	config = function()
		local lspconfig = require("lspconfig")
		local utils = require("plugins.lspconfig.utils")
		local ansible_settings = require("plugins.lspconfig.ansible")
		local c_settings = require("plugins.lspconfig.c")
		local go_settings = require("plugins.lspconfig.go")
		local javascript_settings = require("plugins.lspconfig.javascript")
		local latex_settings = require("plugins.lspconfig.latex")
		local lua_settings = require("plugins.lspconfig.lua")
		local python_settings = require("plugins.lspconfig.python")
		local shell_settings = require("plugins.lspconfig.shell")
		lspconfig.bashls.setup({
			capabilities = capabilities,
			on_attach = function()
				utils.on_attach(shell_settings)
			end
		})
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
				vim.api.nvim_create_augroup("go autocmds", {})
				vim.api.nvim_create_autocmd({ "BufWritePost" }, {
					group = "go autocmds",
					callback = function()
						vim.b[vim.api.nvim_get_current_buf()].folds = nil
					end
				})
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
		lspconfig.ansiblels.setup({
			capabilities = capabilities,
			on_attach = function()
				utils.on_attach(ansible_settings)
			end
		})
	end
}
