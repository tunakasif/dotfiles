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
}
