local fn = vim.fn

-- auto install packer
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path
    })
end

-- auto source neovim with new plugin
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- exit if cannot access packer
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- plugins
return packer.startup(
    function()
        use 'wbthomason/packer.nvim' -- packer itself for managment
        use 'christoomey/vim-sort-motion' -- sorting motion: gs
        use 'christoomey/vim-system-copy' -- system copy: cp, cv
        use 'christoomey/vim-tmux-navigator' -- nav to tmux from vim
        use 'godlygeek/tabular' -- aligning with regex
        use {
            'iamcco/markdown-preview.nvim',
            run = 'cd app && yarn install',
            cmd = 'MarkdownPreview',
            ft = {'markdown'}
        }
        use 'junegunn/goyo.vim' -- zen mode for vim
        use {
            'lervag/vimtex',
            ft = {'tex', 'bib'}
        }
        -- use 'nvie/vim-flake8'
        use {
            'plasticboy/vim-markdown',
            ft = {'markdown'}
        }
        use 'rafi/awesome-vim-colorschemes' -- additional color like gruvbox
        use {
            'rust-lang/rust.vim',
            ft = {'rs'}
        }
        -- use 'sheerun/vim-polyglot'
        use 'tpope/vim-commentary' -- toggle comments: gc
        use 'tpope/vim-fugitive' -- git extension
        use 'tpope/vim-surround' -- adding/changing surrounding env
        use 'vim-airline/vim-airline'
        use 'vim-airline/vim-airline-themes'
        -- use 'vim-syntastic/syntastic'

        -- auto-completion
        use 'hrsh7th/nvim-cmp' -- auto-completion
        use 'hrsh7th/cmp-buffer' -- buffer completions
        use 'hrsh7th/cmp-path' -- path completions
        use 'hrsh7th/cmp-nvim-lsp'
        use 'hrsh7th/cmp-nvim-lua'
        use 'saadparwaiz1/cmp_luasnip' -- snippet completions
        use 'L3MON4D3/LuaSnip' -- snippet engine
        use 'rafamadriz/friendly-snippets' -- bunch of snippets
    end
)

