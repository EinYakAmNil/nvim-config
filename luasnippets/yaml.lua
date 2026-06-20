local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local c = ls.choice_node
local i = ls.insert_node
local s = ls.snippet
local t = ls.text_node

local owner_group_mode = fmt(
	[[
		owner: {}
		group: {}
		mode: '{}'
		]], {
		i(1),
		rep(1),
		c(2, {
			t("0644"),
			t("0755"),
			t("0600"),
			t("0700"),
			i(nil, "custom")
		})
	})

ls.add_snippets("yaml", {
	s("yaml.ansible", fmt(
		[[
		{}
		# vim:ft=yaml.ansible
		]], { i(1) }
	)),
	s("ogm", owner_group_mode),
})

-- vim:ft=lua
