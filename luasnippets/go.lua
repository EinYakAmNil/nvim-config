require("luasnip.session.snippet_collection").clear_snippets("go")

local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local s = ls.snippet
local c = ls.choice_node
local t = ls.text_node
local f = ls.function_node
local i = ls.insert_node

local function go_package_name()
	local node = vim.treesitter.get_node():tree():root():child(0)
	if node == nil then
		error("Can't get root node")
		return
	end
	local query = assert(vim.treesitter.query.get("go", "package-name"), "no query")
	for _, identifier in query:iter_captures(node, 0) do
		return vim.treesitter.get_node_text(identifier, 0)
	end
end

local function go_func_name()
	local func_name = ""
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
	local func_query = assert(vim.treesitter.query.get("go", "func-name"), "no query")
	for _, identifier in func_query:iter_captures(node, 0) do
		func_name = vim.treesitter.get_node_text(identifier, 0)
	end
	local receiv_query = assert(vim.treesitter.query.get("go", "receiv-name"), "no query")
	for _, identifier in receiv_query:iter_captures(node, 0) do
		return vim.treesitter.get_node_text(identifier, 0) .. "." .. func_name
	end
	return func_name
end

---@return string
local function go_call_expr()
	local xy = vim.api.nvim_win_get_cursor(0)
	local node = vim.treesitter.get_node()
	if node == nil then
		return ""
	end
	local call_expr_query = assert(vim.treesitter.query.get("go", "call-func"), "no query")
	local call_expr = ""
	for _, n in call_expr_query:iter_captures(node, 0) do
		local _, start_col = vim.treesitter.get_node_range(n)
		if vim.treesitter.is_in_node_range(n, xy[1] - 2, start_col) then
			call_expr = vim.treesitter.get_node_text(n, 0)
			return call_expr
		end
	end
	return ""
end

---@return string
local function go_field_name()
	local xy = vim.api.nvim_win_get_cursor(0)
	local node = vim.treesitter.get_node({ pos = { xy[1] - 1, 0 } })
	if node == nil then
		return ""
	end
	local field_name_query = assert(vim.treesitter.query.get("go", "field-name"), "no query")
	local field_name = ""
	for _, n in field_name_query:iter_captures(node, 0) do
		local _, start_col = vim.treesitter.get_node_range(n)
		local in_range = vim.treesitter.is_in_node_range(n, xy[1] - 1, start_col)
		if in_range then
			field_name = vim.treesitter.get_node_text(n, 0):gsub("^%u", string.lower)
			return field_name
		end
	end
	return ""
end

ls.add_snippets("go", {
	s("if err", fmta(
		[[
		if <err> != nil {
			<err_rep1> = fmt.Errorf("<call_expr>: %w\n"+
				"<package_name>/<func_name>", <err_rep2>,
			)
			<return_type>
		}
		]], {
			err = i(1, "err"),
			err_rep1 = rep(1),
			call_expr = f(go_call_expr),
			func_name = f(go_func_name),
			package_name = f(go_package_name),
			err_rep2 = rep(1),
			return_type = c(2, {
				t("return"),
				t("t.Fatal(err)")
			})
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
	s("struct json", fmta(
		[[
		`json:"<field_name>"`
		]], {
			field_name = f(go_field_name)
		}
	))
})
