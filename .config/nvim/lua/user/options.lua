vim.cmd([[
    syntax on
    filetype indent on
]])

local opts = {
	background = "dark",
	backup = false,
	completeopt = { "menuone", "noselect" },
	conceallevel = 0,
	errorbells = false,
	expandtab = true,
	exrc = true,
	fileencoding = "utf-8",
	foldenable = true,
	foldlevelstart = 99,
	hidden = true,
	hlsearch = true,
	incsearch = true,
	lazyredraw = true,
	mouse = "a",
	number = true,
	numberwidth = 4,
	pumheight = 10,
	relativenumber = true,
	scrolloff = 8,
	shiftwidth = 4,
	showcmd = true,
	showmatch = true,
	showmode = false,
	sidescrolloff = 8,
	signcolumn = "yes:1",
	smartindent = true,
	softtabstop = 4,
	splitbelow = true,
	splitright = true,
	tabstop = 4,
	termguicolors = true,
	undofile = true,
	updatetime = 300,
}

for k, v in pairs(opts) do
	vim.opt[k] = v
end
