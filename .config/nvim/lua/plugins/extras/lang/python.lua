return {
	-- add python to treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "python", "toml" })
		end,
	},

	-- correctly setup mason lsp
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			opts.automatic_installation = true
			vim.list_extend(opts.ensure_installed, { "pyright", "black", "mypy", "ruff", "debugpy" })
		end,
	},

	-- debugger
	-- {
	-- 	"mfussenegger/nvim-dap-python",
	-- 	ft = { "python" },
	-- 	dependencies = {
	-- 		{
	-- 			"mfussenegger/nvim-dap",
	-- 		},
	-- 	},
	-- 	config = function()
	-- 		require("dap-python").setup("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
	-- 	end,
	-- },
}