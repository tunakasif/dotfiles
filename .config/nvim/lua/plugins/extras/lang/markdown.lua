return {
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		ft = { "markdown" },
		config = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
	},

	-- add markdown to treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "markdown", "markdown_inline" })
		end,
	},

	-- correctly setup mason
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "marksman" })
		end,
	},
}
