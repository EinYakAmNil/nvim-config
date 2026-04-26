local telescope = require("telescope.builtin")
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local function open_in_tab(prompt_bufnr)
	local selection = action_state.get_selected_entry()
	actions.close(prompt_bufnr)
	vim.cmd('tab drop ' .. selection.filename)
	vim.api.nvim_win_set_cursor(0, { selection.lnum, selection.col })
end

local lsp_keymap_opts = { noremap = true, silent = true }

local lsp_keymaps = {
	{ "n", "<leader>=", vim.lsp.buf.format,         lsp_keymap_opts },
	{ "n", "<leader>e", function()
		vim.diagnostic.jump({ count = 1, float = true })
	end, lsp_keymap_opts },
	{ "n", "<leader>E", function()
		vim.diagnostic.jump({ count = -1, float = true })
	end, lsp_keymap_opts },
	{ "n", "<leader>K", vim.lsp.buf.hover,          lsp_keymap_opts },
	{ "n", "<leader>r", vim.lsp.buf.rename,         lsp_keymap_opts },
	{ "n", "gd",        vim.lsp.buf.definition,     lsp_keymap_opts },
	{ "n", "gi",        vim.lsp.buf.implementation, lsp_keymap_opts },
	{ "n", "gr", function()
		telescope.lsp_references({
			attach_mappings = function(_, map)
				map('i', '<CR>', open_in_tab)
				map('n', '<CR>', open_in_tab)
				return true
			end
		})
	end, lsp_keymap_opts },
	{ "n", "gt", vim.lsp.buf.type_definition, lsp_keymap_opts },
}

local lsp_configs = {
	ansiblels = {},
	bashls = {},
	ccls = {},
	gopls = {},
	html = {},
	hls = { filetypes = { 'haskell', 'lhaskell', 'cabal' }, },
	lua_ls = require("plugins.lspconfig.lua"),
	pylsp = {},
	terraformls = { filetypes = { "terraform", "hcl" } },
	texlab = {},
	ts_ls = {},
	yamlls = {},
}

---@return string
function _G.lsp_foldtext()
	local first_line = vim.fn.getline(vim.v.foldstart)
		:gsub("\t", string.rep(" ", vim.o.tabstop))
	local last_line = vim.fn.getline(vim.v.foldend)
		:gsub("\t", string.rep(" ", vim.o.tabstop))
	local line_count = vim.v.foldend - vim.v.foldstart + 1 .. " lines"

	local winwidth = vim.fn.winwidth(0)
	local filler_len = winwidth -
		vim.fn.strdisplaywidth(first_line) -
		vim.fn.strdisplaywidth(last_line) - 6 -- number line column width

	if filler_len <= 0 then
		return first_line .. last_line
	end

	local fold_char = "·"
	if #line_count + 2 < filler_len then
		local start = math.floor((filler_len - #line_count) / 2) + 1
		local filler = string.rep(fold_char, start - 1) ..
			line_count ..
			string.rep(fold_char, filler_len - #line_count - start + 1)
		return first_line .. filler .. last_line
	end

	return first_line .. string.rep(fold_char, filler_len) .. last_line
end

return {
	"neovim/nvim-lspconfig",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	event = "FileType",
	config = function()
		vim.opt.signcolumn = "yes"
		vim.opt.foldmethod = 'expr'
		vim.opt.foldexpr = 'v:lua.vim.lsp.foldexpr()'
		vim.opt.foldtext = "v:lua.lsp_foldtext()"
		for _, keymap in ipairs(lsp_keymaps) do
			---@diagnostic disable-next-line: param-type-mismatch
			vim.keymap.set(unpack(keymap))
		end
		for lsp, config in pairs(lsp_configs) do
			vim.lsp.config(lsp, config)
			vim.lsp.enable(lsp)
		end
	end
}
