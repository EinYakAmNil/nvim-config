local utils = require("plugins.lspconfig.utils")

return {
	keymaps = utils.copy_values(utils.general_keymaps),
	buf_opts = {
		expandtab = true,
		tabstop = 2,
		softtabstop = 2,
		shiftwidth = 2,
	}
}
