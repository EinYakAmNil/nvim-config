local M = {}

M.keymap_opt = { noremap = true, silent = true, buffer = 0 }
M.general_keymaps = {
	{ "n", "<leader>=", vim.lsp.buf.format,          M.keymap_opt },
	{ "n", "<leader>e", vim.diagnostic.goto_next,    M.keymap_opt },
	{ "n", "<leader>E", vim.diagnostic.goto_prev,    M.keymap_opt },
	{ "n", "<leader>K", vim.lsp.buf.hover,           M.keymap_opt },
	{ "n", "<leader>r", vim.lsp.buf.rename,          M.keymap_opt },
	{ "n", "gd",        vim.lsp.buf.definition,      M.keymap_opt },
	{ "n", "gi",        vim.lsp.buf.implementation,  M.keymap_opt },
	{ "n", "gr",        vim.lsp.buf.references,      M.keymap_opt },
	{ "n", "gt",        vim.lsp.buf.type_definition, M.keymap_opt },
}

function M.copy_values(array)
	cpy = {}
	for i, val in ipairs(array) do
		cpy[i] = val
	end

	return cpy
end

function M.on_attach(buf_settings)
	for _, k in ipairs(buf_settings["keymaps"]) do
		vim.keymap.set(k[1], k[2], k[3], k[4])
	end

	for opt, val in pairs(buf_settings["buf_opts"]) do
		vim.opt_local[opt] = val
	end
end

return M
