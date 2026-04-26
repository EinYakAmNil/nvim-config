local keymap_opts = { noremap = true, silent = true, buffer = 0 }

local keymaps = {
	{ "n", "<F5>",      "<cmd>w<cr><cmd>!lua %<cr>",                            keymap_opts },
	{ "n", "<leader>t", "<cmd>write<cr><cmd>PlenaryBustedFile %<cr>",           keymap_opts },
	{ "n", "<leader>T", "<cmd>write<cr><cmd>PlenaryBustedDirectory tests/<cr>", keymap_opts },
}

return {
	---@param client vim.lsp.Client
	---@param bufnr integer
	---@return nil
	on_attach = function(client, bufnr)
		for _, keymap in ipairs(keymaps) do
			vim.keymap.set(unpack(keymap))
		end
	end
}
