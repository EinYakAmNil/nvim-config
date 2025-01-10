local utils = require("plugins.lspconfig.utils")

return {
	keymaps = utils.copy_values(utils.general_keymaps),
	buf_opts = {}
}
