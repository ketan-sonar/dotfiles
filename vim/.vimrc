set nocompatible

set termguicolors
syntax enable
filetype plugin on

colorscheme desert

set background=dark

set mouse=a

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set autoindent
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

set splitbelow
set splitright

runtime! ftplugin/man.vim

set path+=**
set wildmenu

set rtp^="/Users/ketan/.opam/default/share/ocp-indent/vim"

set backspace=indent,eol,start

inoremap {<CR> {<CR>}<ESC>O
inoremap [<CR> [<CR>]<ESC>O
inoremap (<CR> (<CR>)<ESC>O

" inoremap " ""<ESC>i
" inoremap ' ''<ESC>i

autocmd FileType solidity iabbrev uint uint256
