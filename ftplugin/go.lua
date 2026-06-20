---@type vim.keymap.set.Opts
local keymap_opts = { silent = true, noremap = true, buf = 0 }

vim.keymap.set('n', "<leader>t", function()
	vim.cmd("write")
	local go_dir = vim.fn.expand("%:h")
	local obj = vim.system(
		{ "go", "test", "-short" },
		{ cwd = go_dir, text = true }
	):wait()
	if obj.stderr ~= "" then
		vim.notify(obj.stderr)
	end
	vim.notify(obj.stdout)
end, keymap_opts)
vim.keymap.set('n', "<F5>", "<cmd>w<cr><cmd>!go run .<cr>", keymap_opts)
