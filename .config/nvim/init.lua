local function get_file_path()
   local str = debug.getinfo(2, "S").source:sub(2)
   return str:match("(.*/)")
end

local file_path = get_file_path()
local namespace = "tunakasif"
local lua_scripts = {
    "options",
    "plugins",
    "plugsettings.airline",
    "plugsettings.cmp",
    "telescope",
    "treesitter",
    "autopairs",
    "lsp",
    "keymaps"
}
local vim_scripts = {
    "plugsettings/goyo.vim"
}

for i = 1, #lua_scripts do
    local module = namespace .. "." .. lua_scripts[i]
    require(module)
end

for i = 1, #vim_scripts do
    local module = file_path .. "lua/" .. namespace .. "/" .. vim_scripts[i]
    vim.cmd("source " .. module)
end

