local utils = require("plugins.lspconfig.utils")

local lua_buf_opts = {}
local lua_keymaps = utils.copy_values(utils.general_keymaps)
lua_keymaps[#lua_keymaps + 1] = { "n", "<F5>", "<cmd>w<cr><cmd>!lua %<cr>", utils.keymap_opt }
lua_keymaps[#lua_keymaps + 1] = { "n", "<leader>t", "<cmd>write<cr><cmd>PlenaryBustedFile %<cr>", utils.keymap_opt }
lua_keymaps[#lua_keymaps + 1] = { "n", "<leader>T", "<cmd>write<cr><cmd>PlenaryBustedDirectory tests/<cr>", utils
	.keymap_opt }

return {
	keymaps = lua_keymaps,
	buf_opts = lua_buf_opts,
}
