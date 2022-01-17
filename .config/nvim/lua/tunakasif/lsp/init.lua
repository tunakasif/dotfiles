local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    return
end

local namespace = "tunakasif.lsp."
require(namespace .. "lsp-installer")
require(namespace .. "handlers").setup()

