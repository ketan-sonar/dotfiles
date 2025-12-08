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

call plug#begin()

Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'sheerun/vim-polyglot'
Plug 'andrewradev/sideways.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'jiangmiao/auto-pairs'

call plug#end()

set termguicolors
colorscheme koehler
highlight Normal guibg=#101010
highlight ColorColumn guibg=black

set rtp+=/opt/homebrew/opt/fzf
set rtp+=/opt/homebrew/opt/rg

let mapleader = ' '

nnoremap <leader>w :update<CR>
nnoremap <leader>o :update<CR>:source<CR>
nnoremap <leader>e :Ex<CR>

nnoremap <leader>sf :Files<CR>
nnoremap <leader>sg :Rg<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

let g:easy_align_delimiters = get(g:, 'easy_align_delimiters', {})
let g:easy_align_delimiters['\'] = {
\ 'pattern': '\\',
\ 'left_margin': 1,
\ 'right_margin': 0,
\ 'stick_to_left': 0
\ }

nnoremap <leader>h :SidewaysLeft<CR>
nnoremap <leader>l :SidewaysRight<CR>
