return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = function(_, opts)
			opts.options.section_separators = { left = "", right = "" }
			return opts
		end,
	},
}
