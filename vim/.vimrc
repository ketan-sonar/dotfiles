syntax on
filetype plugin indent on
runtime! ftplugin/man.vim

set number
set relativenumber
set nowrap
set colorcolumn=80
set scrolloff=4

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set smartindent
set incsearch
set ignorecase
set smartcase
set wildmenu
set path+=**

set splitbelow
set splitright

" use ':set list' command to use the following feature
set listchars=tab:»\ ,space:·,nbsp:␣

set hidden
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

set iskeyword-=_

set termguicolors
colorscheme koehler
highlight Normal guibg=#101010
highlight ColorColumn guibg=black

set rtp+=/opt/homebrew/opt/fzf
set rtp+=/opt/homebrew/opt/rg

let mapleader = " "

nnoremap <leader>w :update<CR>
nnoremap <leader>q :quit<CR>
nnoremap <leader>o :update<CR>:source<CR>
nnoremap <leader>e :Ex<CR>
