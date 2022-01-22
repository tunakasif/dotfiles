local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
	return
end

null_ls.setup({
	sources = {
		-- Formatter
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.stylua,

		-- Diagnostics
		null_ls.builtins.diagnostics.flake8,
		null_ls.builtins.diagnostics.chktex,

		-- Other
		null_ls.builtins.completion.spell,
	},
})
