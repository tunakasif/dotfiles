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
	},

	-- mason
	{
		"williamboman/mason.nvim",
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
}
