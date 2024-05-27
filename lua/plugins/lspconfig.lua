vim.opt.signcolumn = "yes"

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
	{ "n", "<leader>e", vim.diagnostic.goto_next,    keymap_opt },
	{ "n", "<leader>E", vim.diagnostic.goto_prev,    keymap_opt },
	{ "n", "<leader>K", vim.lsp.buf.hover,           keymap_opt },
	{ "n", "<leader>r", vim.lsp.buf.rename,          keymap_opt },
	{ "n", "gd",        vim.lsp.buf.definition,      keymap_opt },
	{ "n", "gi",        vim.lsp.buf.implementation,  keymap_opt },
	{ "n", "gr",        vim.lsp.buf.references,      keymap_opt },
	{ "n", "gt",        vim.lsp.buf.type_definition, keymap_opt },
}

local lua_buf_opts = {}
local lua_keymaps = copy_values(general_keymaps)
lua_keymaps[#lua_keymaps + 1] = { "n", "<F5>", "<cmd>w<cr><cmd>!lua %<cr>", keymap_opt }
lua_keymaps[#lua_keymaps + 1] = { "n", "<leader>t", "<cmd>write<cr><cmd>PlenaryBustedFile %<cr>", keymap_opt }
local lua_settings = {
	keymaps = lua_keymaps,
	buf_opts = lua_buf_opts,
}

function _G.go_foldexpr(lnum)
	local fold_ranges = {}
	local node = vim.treesitter.get_node({ pos = { 0, 1 } })
	local i = 1
	while node do
		local start_row, _, end_row = node:range()
		local node_t = node:type()

		if node_t == "method_declaration" or node_t == "function_declaration" then
			start_row, _, end_row = node:range()
			fold_ranges[i] = { start_row + 1, end_row + 1 }
			i = i + 1
		end

		node = node:next_sibling()
	end

	for _, range in ipairs(fold_ranges) do
		if lnum > range[1] and lnum < range[2] then
			return 1
		end
	end

	return 0
end

local go_buf_opts = {
	foldmethod = "expr",
	foldexpr = "v:lua._G.go_foldexpr(v:lnum)",
	foldlevel = 0,
	foldenable = true,
}
local go_keymaps = copy_values(general_keymaps)
go_keymaps[#go_keymaps + 1] = { "n", "<F5>", "<cmd>w<cr><cmd>!go run .<cr>", keymap_opt }
go_keymaps[#go_keymaps + 1] = { "n", "<leader>t", "<cmd>write<cr><cmd>!go test -short<cr>", keymap_opt }
go_keymaps[#go_keymaps + 1] = { "n", "<leader>b", function()
	vim.cmd.write()
	vim.fn.jobstart("go build -C " .. vim.fn.expand("%:h"), {
		stderr_buffered = true,
		on_stderr = function(_, data)
			if data ~= "" then
				print(vim.inspect(data))
			end
		end
	})
end,
	keymap_opt }
local go_settings = {
	keymaps = go_keymaps,
	buf_opts = go_buf_opts,
}

function _G.python_foldexpr(lnum)
	local fold_ranges = {}
	local node = vim.treesitter.get_node({ pos = { 0, 1 } })
	local i = 1
	while node do
		local start_row, _, end_row = node:range()
		local node_t = node:type()

		if node_t == "class_definition" then
			for child in node:iter_children() do
				if child:type() == "block" then
					for cc in child:iter_children() do
						if cc:type() == "function_definition" then
							start_row, _, end_row = cc:range()
							fold_ranges[i] = { start_row + 1, end_row + 2 }
							i = i + 1
						end
					end
				end
			end
		else
			fold_ranges[i] = { start_row + 1, end_row + 2 }
			i = i + 1
		end

		node = node:next_sibling()
	end

	for _, range in ipairs(fold_ranges) do
		if lnum > range[1] and lnum < range[2] then
			return 1
		end
	end
	return 0
end

local python_buf_opts = {
	foldmethod = "expr",
	foldexpr = "v:lua._G.python_foldexpr(v:lnum)",
	foldlevel = 0,
	foldenable = true,
}
local python_keymaps = copy_values(general_keymaps)
python_keymaps[#python_keymaps + 1] = { "n", "<F5>", ":w<cr>:!python %<cr>", keymap_opt }
local python_settings = {
	keymaps = python_keymaps,
	buf_opts = python_buf_opts,
}

local c_settings = {
	keymaps = copy_values(general_keymaps),
	buf_opts = {}
}

local latex_buf_opts = {}
local latex_keymaps = copy_values(general_keymaps)
latex_keymaps[#latex_keymaps+1] = { "n", "<F5>", "<cmd>w<cr><cmd>!pdflatex %<cr>", keymap_opt }
local latex_settings = {
	keymaps = latex_keymaps,
	buf_opts = latex_buf_opts,
}

return {
	"neovim/nvim-lspconfig",
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local lspconfig = require("lspconfig")
		lspconfig.ccls.setup({
			capabilities = capabilities,
			on_attach = function()
				on_attach(c_settings)
			end
		})
		lspconfig.pylsp.setup({
			capabilities = capabilities,
			on_attach = function()
				on_attach(python_settings)
			end,
		})
		lspconfig.gopls.setup({
			capabilities = capabilities,
			on_attach = function()
				on_attach(go_settings)
			end
		})
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
		lspconfig.texlab.setup({
			capabilities = capabilities,
			on_attach = function()
				on_attach(latex_settings)
			end
		})
	end
}
