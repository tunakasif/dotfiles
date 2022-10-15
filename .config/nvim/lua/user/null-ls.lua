local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local completion = null_ls.builtins.completion
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = false,
	sources = {
		completion.spell,

		formatting.prettier,
		formatting.black,
		formatting.stylua,
		formatting.latexindent.with({
			filetypes = { "tex", "bib" },
		}),

		diagnostics.flake8,
		diagnostics.chktex,
		diagnostics.gitlint,
		diagnostics.mlint,
	},
})
