local namespace = "tunakasif"
local lua_scripts = {
    "options",
    "plugins",
    "cmp",
    "telescope",
    "treesitter",
    "autopairs",
    "lsp",
    "keymaps"
}

for i = 1, #lua_scripts do
    local module = namespace .. "." .. lua_scripts[i]
    require(module)
end

