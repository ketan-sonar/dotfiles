set nocompatible
set termguicolors
syntax on
filetype plugin on

colorscheme koehler
" colorscheme retrobox
" Make the background transparent
" autocmd ColorScheme * highlight Normal guibg=NONE ctermbg=NONE

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
" Change the color of ColorColumn
" autocmd ColorScheme * highlight ColorColumn ctermfg=102 ctermbg=234 guifg=#928374 guibg=#1c1c1c

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

inoremap " ""<ESC>i
inoremap ' ''<ESC>i

autocmd FileType solidity iabbrev uint uint256

set rtp+=/opt/homebrew/opt/fzf
