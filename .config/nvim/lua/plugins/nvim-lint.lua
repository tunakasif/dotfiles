return {
	"mfussenegger/nvim-lint",
	opts = function(_, opts)
		opts.linters_by_ft = vim.tbl_extend("force", opts.linters_by_ft or {}, {
			markdown = { "markdownlint-cli2" },
			nix = { "statix" },
			python = { "mypy" },
		})
	end,
}
