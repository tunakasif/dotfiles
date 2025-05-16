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
			javascript = { "prettier", "prettierd" },
			tex = { "latexindent", "trim_whitespace" },
			toml = function(bufnr)
				local full = vim.api.nvim_buf_get_name(bufnr)
				if full == "" then
					return {}
				end
				local name = vim.fn.fnamemodify(full, ":t")
				if name:match("pyproject.*%.toml") ~= nil then
					return { "pyproject-fmt", "trim_whitespace" }
				else
					return { "trim_whitespace" }
				end
			end,
			["_"] = { "trim_whitespace" },
		},
	},
}
