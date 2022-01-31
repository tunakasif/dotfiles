local namespace = "tunakasif"
local colorschemes = {
	"nightfox",
	"tokyonight",
	"vscode",
	"gruvbox-baby",
	"gruvbox-material",
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
	"nvim-tree",
	"bufferline",
	"lualine",
	"toggleterm",
	"lsp",
	"null-ls",
	"zenmode",
	"copilot",
	"keymaps",
}

for i = 1, #lua_scripts do
	local module = namespace .. "." .. lua_scripts[i]
	require(module)
end
