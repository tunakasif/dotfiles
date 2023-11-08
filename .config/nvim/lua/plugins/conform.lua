return {
	"stevearc/conform.nvim",
	keys = {
		{
			"<leader>fs",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = function(bufnr)
				if require("conform").get_formatter_info("ruff_format", bufnr).available then
					return { "ruff_fix", "ruff_format" }
				else
					return { "isort", "black" }
				end
			end,
			javascript = { { "prettierd", "prettier" } },
			tex = { "latexindent", "trim_whitespace" },
			["_"] = { "trim_whitespace" },
		},
	},
}
