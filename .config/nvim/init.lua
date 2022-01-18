local namespace = "tunakasif"
local colorschemes = {
    "nightfox",
    "tokyonight",
    "gruvbox-baby",
    "gruvbox-material"
}

local lua_scripts = {
    "colorschemes." .. colorschemes[1],
    "options",
    "plugins",
    "cmp",
    "telescope",
    "treesitter",
    "autopairs",
    "gitsigns",
    "transparent.transparent",
    "lsp",
    "keymaps"
}

for i = 1, #lua_scripts do
    local module = namespace .. "." .. lua_scripts[i]
    require(module)
end

