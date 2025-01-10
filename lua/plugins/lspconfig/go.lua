local utils = require("plugins.lspconfig.utils")

function _G.go_foldexpr(lnum)
	local fold_ranges = {}
	local node = vim.treesitter.get_node({ pos = { 0, 1 } })
	local i = 1
	while node do
		local start_row, _, end_row = node:range()
		local node_t = node:type()

		if node_t == "method_declaration" or node_t == "function_declaration" then
			start_row, _, end_row = node:range()
			fold_ranges[i] = { start_row + 1, end_row + 1 }
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

local go_buf_opts = {
	foldmethod = "expr",
	foldexpr = "v:lua._G.go_foldexpr(v:lnum)",
	foldlevel = 0,
	foldenable = true,
	formatoptions = "cqjor",
}
local go_keymaps = utils.copy_values(utils.general_keymaps)
go_keymaps[#go_keymaps + 1] = { "n", "<F5>", "<cmd>w<cr><cmd>!go run .<cr>", utils.keymap_opt }
go_keymaps[#go_keymaps + 1] = { "n", "<leader>t", function()
	vim.cmd("write")
	local go_dir = vim.fn.expand("%:h")
	local obj = vim.system(
		{ "go", "test" },
		{ cwd = go_dir, text = true }
	):wait()
	if obj.stderr ~= "" then
		vim.notify(obj.stderr)
	end
	vim.notify(obj.stdout)
end,
	utils.keymap_opt }
go_keymaps[#go_keymaps + 1] = { "n", "<leader>b", function()
	vim.cmd.write()
	vim.fn.jobstart("go build -C " .. vim.fn.expand("%:h"), {
		stderr_buffered = true,
		on_stderr = function(_, data)
			if #data == 1 then
				print("Build successful.")
				return
			end
			msg = ""
			for _, line in ipairs(data) do
				msg = msg .. line
			end
			print(msg)
		end
	})
end,
	utils.keymap_opt }

return {
	keymaps = go_keymaps,
	buf_opts = go_buf_opts,
}
