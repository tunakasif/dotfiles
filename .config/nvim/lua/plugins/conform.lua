return {
	"stevearc/conform.nvim",
	keys = {
		{
			"<leader>fs",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	opts = function(_, opts)
		opts.formatters_by_ft = vim.tbl_extend("force", opts.formatters_by_ft or {}, {
			bash = { "shfmt", "shellcheck" },
			bib = { "bibtex_tidy" },
			cpp = { "clang-format" },
			lua = { "stylua" },
			python = function(bufnr)
				local formatters = {}
				if require("conform").get_formatter_info("ruff_format", bufnr).available then
					formatters = { "ruff_format", "ruff_fix" }
				else
					formatters = { "isort", "black" }
				end
				if require("conform").get_formatter_info("mypy", bufnr).available then
					table.insert(formatters, "mypy")
				end
				return formatters
			end,
			javascript = { "prettier", "prettierd" },
			json = { "prettier", "prettierd" },
			nix = { "nixfmt", "statix" },
			rust = { "rustfmt" },
			sh = { "shfmt", "shellcheck" },
			shell = { "shfmt", "shellcheck" },
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
			typst = { "typstyle", "trim_whitespace" },
			zsh = { "shfmt", "shellcheck" },
			["_"] = { "trim_whitespace" },
		})
		opts.formatters = vim.tbl_extend("force", opts.formatters or {}, {
			bibtex_tidy = {
				command = "bibtex-tidy",
				stdin = true,
				args = {
					"--align=14",
					"--blank-lines",
					"--curly",
					"--duplicates",
					"--no-merge",
					"--no-wrap",
					"--sort=year,key,name",
				},
			},
		})
	end,
}
