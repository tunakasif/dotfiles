-- auto install packer
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

-- auto source neovim with new plugin
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- exit if cannot access packer
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- plugins
return packer.startup(function()
	use("wbthomason/packer.nvim") -- packer itself for managment
	use("nvim-lua/popup.nvim") -- lua functions used by lots of plugins
	use("nvim-lua/plenary.nvim") -- lua functions used by lots of plugins

	use("christoomey/vim-sort-motion") -- sorting motion: gs
	use("christoomey/vim-system-copy") -- system copy: cp, cv
	use("christoomey/vim-tmux-navigator") -- nav to tmux from vim
	use("godlygeek/tabular") -- aligning with regex
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && yarn install",
		cmd = "MarkdownPreview",
		ft = { "markdown" },
	})
	use("junegunn/goyo.vim") -- zen mode for vim
	use({
		"rust-lang/rust.vim",
		ft = { "rs" },
	})
	use("tpope/vim-commentary") -- toggle comments: gc
	use("tpope/vim-surround") -- adding/changing surrounding env
	use("xiyaowong/nvim-transparent")
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-media-files.nvim")
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use({
		"p00f/nvim-ts-rainbow",
		requires = { "nvim-treesitter/nvim-treesitter" },
	})
	use({
		"windwp/nvim-autopairs",
		requires = { "nvim-treesitter/nvim-treesitter" },
	})
	use({
		"windwp/nvim-ts-autotag",
		requires = { "nvim-treesitter/nvim-treesitter" },
	})
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
	})
	use({
		"kyazdani42/nvim-tree.lua",
		requires = { "kyazdani42/nvim-web-devicons" },
	})
	use({
		"akinsho/bufferline.nvim",
		requires = "kyazdani42/nvim-web-devicons",
	})
	use("moll/vim-bbye")
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	use("akinsho/toggleterm.nvim")
	use({
		"ellisonleao/glow.nvim",
		opt = true,
		ft = { "markdown" },
	})
	use({
		"plasticboy/vim-markdown",
		ft = { "markdown" },
	})

	-- Deprecated plugins
	-- use {
	--     'lervag/vimtex',
	--     ft = {'tex', 'bib'}
	-- }
	-- use 'tpope/vim-fugitive' -- git extension
	-- use 'sheerun/vim-polyglot'
	-- use 'vim-syntastic/syntastic'
	-- use 'nvie/vim-flake8'

	-- auto-completion
	use("hrsh7th/nvim-cmp") -- auto-completion
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("L3MON4D3/LuaSnip") -- snippet engine
	use("rafamadriz/friendly-snippets") -- bunch of snippets
	use("github/copilot.vim") -- copilot

	-- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	use("williamboman/nvim-lsp-installer") -- simple to use LS installer

	-- Null LS
	use("jose-elias-alvarez/null-ls.nvim")

	-- Visual
	use("folke/twilight.nvim")
	use({
		"folke/zen-mode.nvim",
		requires = { "folke/twilight.nvim", opt = true },
	})
	use("sainnhe/gruvbox-material")
	use("luisiacc/gruvbox-baby")
	use("folke/tokyonight.nvim")
	use("EdenEast/nightfox.nvim")
	use("Mofiqul/vscode.nvim")
end)
