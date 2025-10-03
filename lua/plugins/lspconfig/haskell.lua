local utils = require("plugins.lspconfig.utils")

return {
	keymaps = utils.copy_values(utils.general_keymaps),
	buf_opts = {
		expandtab = true,
		tabstop = 4,
		softtabstop = 4,
		shiftwidth = 4,
	}
}
