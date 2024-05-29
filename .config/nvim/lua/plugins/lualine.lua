return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = function(_, opts)
			opts.options.section_separators = { left = "", right = "" }
			local prose = require("nvim-prose")
			table.insert(opts.sections.lualine_x, { prose.word_count, cond = prose.is_available })
			return opts
		end,
	},
}
