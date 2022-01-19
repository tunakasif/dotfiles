local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
    return
end

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.latexindent.with(
            {
                extra_args = {
                    ""
                }
            }
        ),
        null_ls.builtins.diagnostics.flake8,
        null_ls.builtins.completion.spell,
    },
})
