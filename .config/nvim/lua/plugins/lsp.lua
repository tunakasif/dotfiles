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
				rust_analyzer = {
					mason = false,
					settings = {
						["rust-analyzer"] = {
							imports = {
								granularity = {
									group = "module",
								},
								prefix = "self",
							},
							cargo = {
								allFeatures = true,
								buildScripts = {
									enable = true,
								},
							},
							procMacro = {
								enable = true,
							},
						},
					},
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
				"rust-analyzer",
			},
		},
	},
}
