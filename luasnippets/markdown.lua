local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local s = ls.snippet
-- local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("markdown", {
	s("bash", fmt(
		[[
		```bash
		{}
		```
		]], { i(1) }
	)),
	s("`", fmt(
		[[
		```{}
		{}
		``
		]], { i(1), i(2) }
	)),
})
