local utils = require("plugins.lspconfig.utils")

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
local python_keymaps = utils.copy_values(utils.general_keymaps)
python_keymaps[#python_keymaps + 1] = { "n", "<F5>", ":w<cr>:!python %<cr>", utils.keymap_opt }

return {
	keymaps = python_keymaps,
	buf_opts = python_buf_opts,
}

