--  __   __    __
--  \ \ / /_ _| | __
--  \  V / _` | |/ /
--  |  | (_| |   <
--  |_|\__,_|_|\__\
--
-- Colorpalette
local M = {}
local api = vim.api
local c = {
	black = 232,
	lightblue = 135,
	orange = 154,
	purple = 53,
	grey = 248,
	green = 95,
	lightred = 202,
	red = 124,
	darkred = 52,
	darkblue = 16,
	white = 15,
}

local truec = {
	purple = "#220022",
	lightgrey = "#d3d3d3",
	grey = "#333333",
	orange = "#9fbc00",
	green = "#28a745",
	pale_green = "#87ffaf",
	yellow = "#ffc600",
	red = "#ff2020",
	darkred = "#3e3606",
	lightblue = "#aaaaee",
	blue = "#663eee",
	darkblue = "#1d2386",
	deeppink = "#5f005f",
	deeperpink = "#420042",
}

local hl_theme = {
	-- Default colors
	{ "Normal",                   { fg = truec.lightblue } },
	{ "Conceal",                  { link = "Normal" } },
	{ "Visual",                   { bg = truec.darkred, bold = true } },
	{ "Search",                   { bg = truec.darkblue, bold = true, reverse = true } },
	{ "IncSearch",                { link = "Search" } },
	{ "Pmenu",                    { fg = truec.lightgrey, bg = truec.deeperpink, italic = true } },
	{ "PmenuSel",                 { fg = truec.lightblue, bg = truec.darkred, bold = true } },
	{ "WildMenu",                 { link = "Pmenu" } },
	{ "Folded",                   { fg = truec.yellow, bg = truec.darkred, italic = true } },
	{ "NonText",                  { fg = truec.darkred } },
	-- UI colors
	{ "LineNr",                   { fg = truec.blue, bg = truec.deeperpink } },
	{ "SignColumn",               { link = "LineNr" } },
	{ "CursorLine",               { bg = truec.deeppink } },
	{ "CursorLineNr",             { fg = truec.yellow, bg = truec.deeperpink } },
	{ "WinSeparator",             { link = "LineNr" } },
	{ "TabLine",                  { link = "LineNr" } },
	{ "TabLineSel",               { fg = truec.orange, bg = truec.deeppink, bold = true } },
	{ "TabLineFill",              { bg = truec.deeperpink } },
	-- Syntax specific colors
	{ "Function",                 { link = "@function" } },
	{ "PreProc",                  { fg = truec.green, bold = true } },
	{ "Comment",                  { fg = truec.green, italic = true } },
	{ "Statement",                { fg = truec.orange } },
	{ "Title",                    { fg = truec.blue, bold = true } },
	{ "Constant",                 { fg = truec.yellow } },
	{ "String",                   { fg = truec.blue } },
	{ "Number",                   { link = "String" } },
	{ "Type",                     { fg = truec.pale_green, bold = true } },
	{ "Identifier",               { fg = truec.blue, bold = true } },
	-- Treesitter
	{ "@keyword",                 { fg = truec.yellow, italic = true } },
	{ "@keyword.return",          { fg = truec.yellow } },
	{ "@keyword.operator",        { link = "@keyword.return" } },
	{ "@keyword.function",        { fg = truec.yellow, italic = true } },
	{ "@function",                { fg = truec.orange } },
	{ "@variable",                { fg = truec.lightblue } },
	{ "@parameter",               { italic = true } },
	{ "@field",                   { fg = truec.lightgrey } },
	{ "@property",                { link = "@field" } },
	{ "@method",                  { fg = truec.blue, bold = true } },
	{ "@string.documentation",    { fg = truec.green } },
	{ "@lsp.type.function",       { link = "@function" } },
	{ "@lsp.type.method",         { link = "@method" } },
	{ "@lsp.type.parameter",      { link = "@parameter" } },
	{ "@lsp.type.property",       { link = "@property" } },
	{ "@lsp.type.variable",       { link = "@variable" } },
	{ "@text.strong",             { bold = true } },
	{ "@text.emphasis",           { italic = true } },
	-- Treesitter markdown
	{ "@markup.heading.1.marker", { fg = truec.yellow } },
	{ "@markup.heading.1",        { link = "Identifier" } },
	{ "@markup.heading.2.marker", { fg = truec.yellow } },
	{ "@markup.heading.2",        { link = "Identifier" } },
	{ "@markup.heading.3.marker", { fg = truec.yellow } },
	{ "@markup.heading.3",        { link = "Identifier" } },
	{ "@markup.list",             { fg = truec.yellow } },
	{ "@markup.link.label",       { fg = truec.orange, bold = true, underline = true } },
	{ "@markup.link.url",         { fg = truec.pale_green, italic = true } },
	{ "@markup.italic",           { italic = true } },
	{ "@markup.strong",           { bold = true } },
	{ "@markup.strikethrough",    { strikethrough = true } },
	-- LSP
	{ "DiagnosticError",          { fg = truec.red, undercurl = true } },
	{ "DiagnosticHint",           { fg = truec.lightgrey } },
	{ "DiagnosticInfo",           { fg = truec.blue } },
	{ "DiagnosticWarn",           { fg = truec.orange } },
	{ "DiagnosticSignError",      { fg = truec.red, bg = truec.deeperpink } },
	{ "DiagnosticSignHint",       { fg = truec.lightgrey, bg = truec.deeperpink } },
	{ "DiagnosticSignInfo",       { fg = truec.blue, bg = truec.deeperpink } },
	{ "DiagnosticSignWarn",       { fg = truec.orange, bg = truec.deeperpink } },
	-- Stuff
	{ "@text.reference",          { link = "Identifier" } }
}

for _, hl in ipairs(hl_theme) do
	group = hl[1]
	style = hl[2]
	api.nvim_set_hl(0, group, style)
end

--Export lualine colors
M.lualine = {
	normal = {
		a = { fg = c.lightblue, bg = c.purple, gui = "bold" },
		b = { fg = c.black, bg = c.green },
		c = { fg = c.grey },
	},
	insert = {
		a = { fg = c.purple, bg = c.lightblue, gui = "bold" },
		b = { fg = c.black, bg = c.green },
		c = { fg = c.grey },
	},
	visual = {
		a = { fg = c.purple, bg = c.orange, gui = "bold" },
		b = { fg = c.black, bg = c.green },
		c = { fg = c.grey },
	},
	replace = {
		a = { fg = c.darkred, bg = c.black, gui = "bold" },
		b = { fg = c.black, bg = c.green },
		c = { fg = c.grey },
	},
	command = {
		a = { fg = c.purple, bg = c.green, gui = "bold" },
		b = { fg = c.black, bg = c.green },
		c = { fg = c.grey },
	},
	inactive = {
		a = { fg = c.grey, bg = c.purple, gui = "bold" },
		b = { fg = c.grey, bg = c.darkred },
		c = { fg = c.grey },
	},
}

return M
