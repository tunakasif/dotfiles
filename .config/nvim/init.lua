local namespace = "tunakasif"
local colorschemes = {
	"darkplus",
	"gruvbox-baby",
	"gruvbox-material",
	"nightfox",
	"tokyonight",
	"vscode",
}

local lua_scripts = {
	"colorschemes." .. colorschemes[4],
	"options",
	"plugins",
	"alpha",
	"autopairs",
	"bufferline",
	"cmp",
	"copilot",
	"gitsigns",
	"impatient",
	"lsp",
	"lualine",
	"luasnip",
	"null-ls",
	"nvim-tree",
	"telescope",
	"toggleterm",
	"transparent.transparent",
	"treesitter",
	"vimtex",
	"zenmode",
	"keymaps",
}

for i = 1, #lua_scripts do
	local module = namespace .. "." .. lua_scripts[i]
	require(module)
end
