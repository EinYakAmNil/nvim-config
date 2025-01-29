require("luasnip.session.snippet_collection").clear_snippets("go")

local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local s = ls.snippet
-- local t = ls.text_node
local f = ls.function_node
local i = ls.insert_node

local function go_func_name()
	local func_nodes = {
		function_declaration = true,
		method_declaration = true,
	}
	local node = vim.treesitter.get_node()
	while node ~= nil do
		if func_nodes[node:type()] then
			break
		end
		node = node:parent()
	end
	if not node then
		vim.notify("Not inside a function")
		return ""
	end
	local query = assert(vim.treesitter.query.get("go", "func-name"), "no query")
	for _, identifier in query:iter_captures(node, 0) do
		return vim.treesitter.get_node_text(identifier, 0)
	end
end

ls.add_snippets("go", {
	s("if err", fmta(
		[[
		if <err> != nil {
			<err_rep1> = fmt.Errorf("<func_name>: %w\n", <err_rep2>)
			return
		}
		]], {
			err = i(1, "err"),
			err_rep1 = rep(1),
			func_name = f(go_func_name),
			err_rep2 = rep(1),
		}
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
