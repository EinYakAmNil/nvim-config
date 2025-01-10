local utils = require("plugins.lspconfig.utils")

local js_buf_opts = {}
local js_keymaps = utils.copy_values(utils.general_keymaps)

return {
	keymaps = js_keymaps,
	buf_opts = js_buf_opts,
}
