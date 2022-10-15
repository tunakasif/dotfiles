local fn = vim.fn
-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerInstall
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	-- Packer Settings
	snapshot_path = fn.stdpath("config"),
	snapshot = "packer_snapshot.json",
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/plenary.nvim") -- Useful lua functions used by lots of plugins
	use("nvim-lua/popup.nvim") -- Popup window for messages

	use("ahmedkhalf/project.nvim")
	use("akinsho/bufferline.nvim")
	use("akinsho/toggleterm.nvim")
	use("christoomey/vim-sort-motion") -- sorting motion: gs
	use("christoomey/vim-tmux-navigator") -- nav to tmux from vim
	use("godlygeek/tabular") -- aligning with regex
	use("goolord/alpha-nvim")
	use("kyazdani42/nvim-tree.lua")
	use("kyazdani42/nvim-web-devicons")
	use("lewis6991/impatient.nvim")
	use("lukas-reineke/indent-blankline.nvim")
	use("moll/vim-bbye")
	use("nvim-lualine/lualine.nvim")
	use("RRethy/vim-illuminate")
	use("tpope/vim-commentary") -- toggle comments: gc
	use("tpope/vim-surround") -- adding/changing surrounding env
	use("xiyaowong/nvim-transparent")

	-- Colorschemes
	use("EdenEast/nightfox.nvim")
	use("Mofiqul/vscode.nvim")
	use("folke/tokyonight.nvim")
	use("luisiacc/gruvbox-baby")
	use("lunarvim/darkplus.nvim")
	use("sainnhe/gruvbox-material")
	use({
		"catppuccin/nvim",
		as = "catppuccin",
	})

	-- cmp plugins
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")
	use("hrsh7th/cmp-path") -- path completions
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("github/copilot.vim") -- copilot

	-- snippets
	use("L3MON4D3/LuaSnip") --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	-- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	use("williamboman/nvim-lsp-installer") -- simple to use language server installer
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters

	-- Telescope
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-media-files.nvim")

	-- Treesitter
	use("nvim-treesitter/nvim-treesitter")
	use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use({
		"p00f/nvim-ts-rainbow",
		requires = { "nvim-treesitter/nvim-treesitter" },
	})
	use({
		"windwp/nvim-ts-autotag",
		requires = { "nvim-treesitter/nvim-treesitter" },
	})

	-- Spellcheck
	use({ "barreiroleo/ltex-extra.nvim" })

	-- Troubleshooting
	use("folke/trouble.nvim")

	-- Git
	use({ "lewis6991/gitsigns.nvim" })

	-- DAP
	use({ "mfussenegger/nvim-dap" })
	use({ "ravenxrz/DAPInstall.nvim" })
	use({ "rcarriga/nvim-dap-ui" })

	-- Markdown
	use({
		"plasticboy/vim-markdown",
		ft = { "markdown", "md" },
	})
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && yarn install",
		cmd = "MarkdownPreview",
		ft = { "md", "markdown" },
	})
	use({ "ellisonleao/glow.nvim", opt = true, ft = { "md", "markdown" } })

	-- LaTeX
	use("lervag/vimtex")

	-- Rust
	use({ "rust-lang/rust.vim", ft = { "rs" } })
	use("simrat39/rust-tools.nvim")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
