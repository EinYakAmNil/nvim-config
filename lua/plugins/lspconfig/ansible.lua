local utils = require("plugins.lspconfig.utils")

local ansible_buf_opts = {
	formatoptions = "cqjol",
	comments = ":#,:-"
}

local ansible_keymaps = utils.copy_values(utils.general_keymaps)

return {
	keymaps = ansible_keymaps,
	buf_opts = ansible_buf_opts,
}
