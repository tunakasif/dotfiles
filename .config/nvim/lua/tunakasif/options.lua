vim.cmd([[
    syntax on
    filetype indent on
    colorscheme gruvbox
    autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
]])

local opts = {
    termguicolors = true,
    background = "dark",
    encoding="utf-8",
    mouse="a",
    exrc = true,
    number = true,
    relativenumber = true,
    hidden = true,
    undofile = true,
    errorbells = false,
    expandtab = true,
    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
    numberwidth = 4,
    smartindent = true,
    showcmd = true,
    wildmenu = true,
    wildmode = {"longest", "list" , "full"},
    lazyredraw = true,
    showmatch = true,
    incsearch = true,
    hlsearch = true,
    scrolloff = 8,
    sidescrolloff = 8,
    foldenable = true,
    foldlevelstart = 99,
    splitbelow = true,
    splitright = true,
    signcolumn = "number",
}

for k, v in pairs(opts) do
  vim.opt[k] = v
end

