-- setup global mapleader
vim.g.mapleader = " "

-- set cursor
vim.opt.guicursor = ""

-- setup tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- setup line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- general
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.scrolloff = 4
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"
vim.opt.cursorline = true

-- setup undodir
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"
vim.opt.undofile = true

-- nice searching
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- setup splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- set updatetime
vim.opt.updatetime = 50
