local status_ok, catppuccin = pcall(require, "catppuccin")
if not status_ok then
	return
end

vim.g.catppuccin_flavour = "mocha"

catppuccin.setup({
	compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
	styles = {
		comments = { "italic" },
		conditionals = { "italic" },
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
	},
	integrations = {
		cmp = true,
		gitsigns = true,
		nvimtree = true,
		telescope = true,
		treesitter = true,
		ts_rainbow = true,
		lsp_trouble = true,
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
			},
			underlines = {
				errors = { "undercurl" },
				warnings = { "undercurl" },
				hints = { "underdot" },
				information = { "underdash" },
			},
		},
	},
})

vim.cmd("colorscheme catppuccin")
