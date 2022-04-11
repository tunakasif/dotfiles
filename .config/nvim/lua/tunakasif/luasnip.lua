local status_ok, luasnip = pcall(require, "luasnip")
if not status_ok then
	return
end

-- local types = require("luasnip.util.types")
luasnip.config.set_config({
	history = true,
	updateevents = "TextChanged,TextChangedI",
	enable_autosnippets = true,
})

luasnip.add_snippets("all", {
	luasnip.snippet("tuna_test", {
		-- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
		luasnip.insert_node(1, "cond"),
		luasnip.text_node(" ? "),
		luasnip.insert_node(2, "then"),
		luasnip.text_node(" : "),
		luasnip.insert_node(3, "else"),
	}),
})

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").load({
	paths = { "~/.config/Code/User" },
})

-- require("luasnip.loaders.from_vscode").load()
-- local snippet_path = vim.fn.stdpath("config") .. "/lua/tunakasif/my-snippets/"
