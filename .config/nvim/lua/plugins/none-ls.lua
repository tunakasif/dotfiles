return {
	{
		"nvimtools/none-ls.nvim",
		opts = function(_, opts)
			local nls = require("null-ls")
			table.insert(opts.sources, nls.builtins.formatting.latexindent)
			table.insert(opts.sources, nls.builtins.formatting.black)
			table.insert(opts.sources, nls.builtins.formatting.isort)
			table.insert(opts.sources, nls.builtins.diagnostics.mypy)
			table.insert(opts.sources, nls.builtins.diagnostics.ruff)
		end,
	},
}
