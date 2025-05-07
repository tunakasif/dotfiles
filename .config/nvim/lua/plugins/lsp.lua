return {
	-- lspconfig
	{
		"neovim/nvim-lspconfig",
		---@class PluginLspOpts
		opts = {
			format = { timeout_ms = 5000 },
			diagnostics = {
				float = {
					border = "rounded",
				},
			},
		},
		keys = {
			{ "<C-k>", false, mode = { "i", "n", "s", "v" } },
		},
	},

	-- mason
	{
		"williamboman/mason.nvim",
		-- Pin version
		version = "1.11.0",
		opts = {
			ensure_installed = {
				"stylua",
				"shellcheck",
				"shfmt",
				"flake8",
				"texlab",
			},
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		-- Pin version
		version = "1.32.0",
	},
}
