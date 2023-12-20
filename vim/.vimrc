set nocompatible

set termguicolors
syntax enable
filetype plugin on

colorscheme desert
highlight Normal guibg=#181818

set mouse=a

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set smartindent

set number
set relativenumber

set nohlsearch
set incsearch
set ignorecase
set smartcase
set noerrorbells

set hidden
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

set scrolloff=4
set colorcolumn=80
" highlight ColorColumn ctermbg=lightgrey guibg=lightgrey

set splitbelow
set splitright

runtime! ftplugin/man.vim

set path+=**
set wildmenu
