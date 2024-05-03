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
		]], { i(1) }
	)),
	s("catch err", fmt(
		[[
		var possibleErr interface{{}}
		var err error
		defer func(possibleErr interface{{}}) {{
			possibleErr = recover()
			if possibleErr != nil {{
				err = errors.New(fmt.Sprint(possibleErr))
			}}
		}}(possibleErr)
		{}
		return err
		]], { i(1) }
	)),
})
