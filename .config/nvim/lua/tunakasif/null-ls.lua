local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local completion = null_ls.builtins.completion

null_ls.setup({
	debug = false,
	sources = {
		-- Formatter
		formatting.black,
		formatting.prettier,
		formatting.stylua,
		formatting.mdformat,

		-- Diagnostics
		diagnostics.flake8,
		diagnostics.chktex,

		-- Other
		completion.spell,
	},
})
