return {
	{
		"lervag/vimtex",
		lazy = true,
		event = "BufRead",
		init = function()
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_quickfix_open_on_warning = 0
		end,
	},
	{
		"folke/which-key.nvim",
		optional = true,
		opts = {
			defaults = {
				["<localLeader>l"] = { name = "+vimtex" },
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "bibtex", "latex" })
			end
			if type(opts.highlight.disable) == "table" then
				vim.list_extend(opts.highlight.disable, { "latex" })
			else
				opts.highlight.disable = { "latex" }
			end
		end,
	},
}
