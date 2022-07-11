local status_ok, luasnip = pcall(require, "luasnip")
if not status_ok then
	return
end

local home_path = os.getenv("HOME")
local vs_code_user_dir = home_path .. "/.config/Code/User"
local vs_code_user_file = "package.json"
local vs_code_user_file_path = vs_code_user_dir .. "/" .. vs_code_user_file

local function file_exists(name)
	local f = io.open(name, "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

-- local types = require("luasnip.util.types")
luasnip.config.set_config({
	history = true,
	updateevents = "TextChanged,TextChangedI",
	enable_autosnippets = true,
})

luasnip.add_snippets("all", {
	luasnip.snippet("ternary_op", {
		-- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
		luasnip.insert_node(1, "cond"),
		luasnip.text_node(" ? "),
		luasnip.insert_node(2, "then"),
		luasnip.text_node(" : "),
		luasnip.insert_node(3, "else"),
	}),
})

require("luasnip.loaders.from_vscode").lazy_load()

if file_exists(vs_code_user_file_path) then
	require("luasnip.loaders.from_vscode").load({
		paths = { vs_code_user_dir },
	})
else
	print("" .. vs_code_user_file_path .. " does not exist.")
end

-- require("luasnip.loaders.from_vscode").load()
-- local snippet_path = vim.fn.stdpath("config") .. "/lua/tunakasif/my-snippets/"
