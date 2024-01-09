vim.opt.signcolumn = "yes"

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

local function copy_values(array)
	cpy = {}
	for i, val in ipairs(array) do
		cpy[i] = val
	end

	return cpy
end

local function on_attach(buf_settings)
	for _, k in ipairs(buf_settings["keymaps"]) do
		vim.keymap.set(k[1], k[2], k[3], k[4])
	end

	for opt, val in pairs(buf_settings["buf_opts"]) do
		vim.opt_local[opt] = val
	end
end

local keymap_opt = { noremap = true, silent = true, buffer = 0 }
local general_keymaps = {
	{ "n", "<leader>=", vim.lsp.buf.format,          keymap_opt },
	{ "n", "<leader>K", vim.lsp.buf.hover,           keymap_opt },
	{ "n", "<leader>r", vim.lsp.buf.rename,          keymap_opt },
	{ "n", "gd",        vim.lsp.buf.definition,      keymap_opt },
	{ "n", "gt",        vim.lsp.buf.type_definition, keymap_opt },
	{ "n", "gi",        vim.lsp.buf.implementation,  keymap_opt },
}

local lua_buf_opts = {}
local lua_keymaps = copy_values(general_keymaps)
lua_keymaps[#lua_keymaps + 1] = { "n", "<F5>", "<cmd>w<cr><cmd>!lua %<cr>", keymap_opt }
lua_keymaps[#lua_keymaps + 1] = { "n", "<leader>t", "<cmd>write<CR><cmd>PlenaryBustedFile %<CR>", keymap_opt }
local lua_settings = {
	keymaps = lua_keymaps,
	buf_opts = lua_buf_opts,
}
lspconfig.lua_ls.setup({
	capabilities = capabilities,
	on_attach = function()
		on_attach(lua_settings)
	end,
	settings = {
		Lua = {
			diagnostics = {
				disable = { "lowercase-global" },
			},
		},
	},
})

local go_buf_opts = {}
local go_keymaps = copy_values(general_keymaps)
go_keymaps[#go_keymaps + 1] = { "n", "<F5>", "<cmd>w<cr><cmd>!go run .<cr>", keymap_opt }
go_keymaps[#go_keymaps + 1] = { "n", "<leader>b", "<cmd>w<cr><cmd>!go build -C " .. vim.fn.expand("%:h") .. "<cr>",
	keymap_opt }
local go_settings = {
	keymaps = go_keymaps,
	buf_opts = go_buf_opts,
}
lspconfig.gopls.setup({
	capabilities = capabilities,
	on_attach = function()
		on_attach(go_settings)
	end
})
