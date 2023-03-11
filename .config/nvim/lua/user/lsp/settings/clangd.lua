local caps = vim.lsp.protocol.make_client_capabilities()
caps.offsetEncoding = { "utf-16" }

return {
	capabilities = caps,
	cmd = {
		"clangd",
		"--background-index",
		"--suggest-missing-includes",
		"--clang-tidy",
		"--header-insertion=iwyu",
		"--offset-encoding=utf-16",
		"-I include",
	},
}
