local namespace = "tunakasif.lsp."
local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
    return
end

local function has_value (tab, val)
    for _, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

lsp_installer.on_server_ready(function(server)
    local handlers = namespace .. "handlers"
    local opts = {
        on_attach = require(handlers).on_attach,
        capabilities = require(handlers).capabilities,
    }

    local server_names = {"jsonls", "pyright", "rust_analyzer", "sumneko_lua"}
    if has_value(server_names, server.name) then
       local additional_opts = require(namespace .. "settings." .. server.name)
       opts = vim.tbl_deep_extend("force", additional_opts, opts)
    end

    server:setup(opts)
end)


