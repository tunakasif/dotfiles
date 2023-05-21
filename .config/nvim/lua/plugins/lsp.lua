return {
	-- lspconfig
	{
		"neovim/nvim-lspconfig",
		---@class PluginLspOpts
		opts = {
			setup = {
				clangd = function(_, opts)
					opts.capabilities.offsetEncoding = { "utf-16" }
				end,
			},
			format = { timeout_ms = 5000 },
			---@type lspconfig.options
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
	{ import = "plugins.extras.lang.markdown" },
}
