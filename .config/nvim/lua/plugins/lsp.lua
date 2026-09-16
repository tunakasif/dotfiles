return {
	-- lspconfig
	{
		"neovim/nvim-lspconfig",
		---@class PluginLspOpts
		opts = {
			servers = {
				ltex = {
					settings = {
						ltex = {
							checkFrequency = "save",
						},
					},
				},
			},
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
}
