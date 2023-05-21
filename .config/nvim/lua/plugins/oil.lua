return {
	{
		"stevearc/oil.nvim",
		keys = {
			{ "<localleader>-", "<cmd>Oil<cr>", desc = "Open Parent Directory" },
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		init = function()
			require("oil").setup()
		end,
	},
}
