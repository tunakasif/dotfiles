"install vim-plug and add `autoload` to it" 
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"plugins using vim-plug"
call plug#begin('~/.vim/plugged')

"Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }"
Plug 'christoomey/vim-sort-motion' 
Plug 'godlygeek/tabular'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'junegunn/goyo.vim'
Plug 'nvie/vim-flake8'
Plug 'plasticboy/vim-markdown'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'rust-lang/rust.vim'
Plug 'sheerun/vim-polyglot' 
Plug 'tpope/vim-commentary' 
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround' 
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-syntastic/syntastic'

call plug#end()

"theme"
set background=dark
colorscheme gruvbox

"general settings"
let python_highlight_all=1
syntax on
filetype indent on
set encoding=utf-8
set number relativenumber
set tabstop=4
set softtabstop=4
set showcmd
set wildmenu
set wildmode=longest,list,full
set lazyredraw
set showmatch
set incsearch
set hlsearch
set foldenable
set foldlevelstart=99
set splitbelow
set splitright

"remapping key-bindings"
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"airline settings"
let g:airline_section_z = airline#section#create(['linenr', '/%L', ':%v'])
let g:airline_powerline_fonts = 1

