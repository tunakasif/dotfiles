return {
	{
		"numToStr/Navigator.nvim",
		lazy = true,
		config = function()
			require("Navigator").setup({
				auto_save = "current",
			})
		end,
		keys = {
			{ "<A-h>", "<cmd>NavigatorLeft<cr>" },
			{ "<A-l>", "<cmd>NavigatorRight<cr>" },
			{ "<A-k>", "<cmd>NavigatorUp<cr>" },
			{ "<A-j>", "<cmd>NavigatorDown<cr>" },
		},
	},
}
