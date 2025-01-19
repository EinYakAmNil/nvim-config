local utils = require("plugins.lspconfig.utils")

local latex_buf_opts = {}
local latex_keymaps = utils.copy_values(utils.general_keymaps)
latex_keymaps[#latex_keymaps + 1] = { "n", "<F5>", "<cmd>w<cr><cmd>!pdflatex %<cr>", utils.keymap_opt }
latex_keymaps[#latex_keymaps + 1] = { "n", "<F6>", "<cmd>!zathura %:p:r.pdf disown<cr>", utils.keymap_opt }

return {
	keymaps = latex_keymaps,
	buf_opts = latex_buf_opts,
}
