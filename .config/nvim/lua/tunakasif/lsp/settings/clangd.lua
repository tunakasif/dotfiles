local caps = vim.lsp.protocol.make_client_capabilities()
caps.offsetEncoding = { "utf-16" }

return {
	capabilities = caps,
}
