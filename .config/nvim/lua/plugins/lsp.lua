return {
	-- lspconfig
	{
		"neovim/nvim-lspconfig",
		---@class PluginLspOpts
		opts = {
			---@type lspconfig.options
			format = { timeout_ms = 5000 },
			servers = {
				pyright = {},
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

	{ import = "plugins.extras.lang.rust" },
}
