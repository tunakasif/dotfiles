return {
	"saghen/blink.cmp",
	dependencies = {
		{
			"giuxtaposition/blink-cmp-copilot",
		},
	},
	opts = {
		sources = {
			default = { "copilot", "lsp", "path", "snippets", "buffer" },
		},
		keymap = {
			preset = "enter",
			["<C-y>"] = { "select_and_accept" },
			["<C-j>"] = { "select_next", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
			["<Tab>"] = {
				LazyVim.cmp.map({ "snippet_forward", "ai_accept" }),
				"fallback",
			},
		},
	},
}
