local namespace = "user"
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
	"autocommands",
	"autopairs",
	"bufferline",
	"cmp",
	"copilot",
	"dap",
	"gitsigns",
	"illuminate",
	"impatient",
	"indentline",
	"lsp",
	"lualine",
	"luasnip",
	"null-ls",
	"nvim-tree",
	"project",
	"telescope",
	"toggleterm",
	"transparent.transparent",
	"treesitter",
	"vimtex",
	"keymaps",
}

for i = 1, #lua_scripts do
	local module = namespace .. "." .. lua_scripts[i]
	require(module)
end
