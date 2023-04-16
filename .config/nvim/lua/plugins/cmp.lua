return {
	"hrsh7th/nvim-cmp",
	dependencies = { "hrsh7th/cmp-emoji" },
	---@param opts cmp.ConfigSchema
	opts = function(_, opts)
		local cmp = require("cmp")
		opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
		opts.mapping = cmp.mapping.preset.insert({
			["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
			["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		})
	end,
}
