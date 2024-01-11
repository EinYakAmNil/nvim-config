local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local s = ls.snippet
-- local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("go", {
	s("if err", fmt(
		[[
		if err != nil {{
			{}
		}}
		]], {
			i(1)
		}))
})
