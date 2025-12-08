vim.g.mapleader = " "

vim.opt.termguicolors = true

vim.opt.guicursor = ""

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.wrap = false
vim.opt.signcolumn = "yes"
vim.opt.winborder = "rounded"

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.hidden = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undodir"
vim.opt.undofile = true

vim.opt.scrolloff = 4
vim.opt.colorcolumn = "80"

vim.opt.splitbelow = true
vim.opt.splitright = true

-- use command `set list` to use the following config
vim.opt.listchars = { tab = "» ", space = "·", nbsp = "␣" }

vim.opt.path:append("**")
vim.opt.wildignore:append("*/node_modules/*")
vim.opt.wildignore:append("*/target/*")
vim.opt.iskeyword:remove("_")

vim.api.nvim_create_autocmd("FileType", {
    pattern = "solidity",
    callback = function()
        vim.cmd("iabbrev uint uint256")
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "dart",
        "schema",
        "prisma",
        "css",
        "html",
    },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.shiftwidth = 2
    end,
})

vim.keymap.set("n", "<leader>h", "<C-w><C-h>")
vim.keymap.set("n", "<leader>l", "<C-w><C-l>")
vim.keymap.set("n", "<leader>j", "<C-w><C-j>")
vim.keymap.set("n", "<leader>k", "<C-w><C-k>")

-- quick fix list
vim.keymap.set("n", "<C-j>", "<cmd>cnext<cr>", { desc = "cnext" })
vim.keymap.set("n", "<C-k>", "<cmd>cprev<cr>", { desc = "cprev" })

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup(
        "kickstart-highlight-yank",
        { clear = true }
    ),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.keymap.set("n", "<leader>o", ":update<CR>:source<CR>")
vim.keymap.set("n", "<leader>w", ":update<CR>")
vim.keymap.set("n", "<leader>q", ":quit<CR>")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-flutter/flutter-tools.nvim",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/ibhagwan/fzf-lua",
    "https://github.com/windwp/nvim-autopairs",
    "https://github.com/christoomey/vim-tmux-navigator",
    "https://github.com/catppuccin/nvim",
})

require("catppuccin").setup({
    flavour = "mocha",
    no_italic = true,
    no_bold = true,
})
vim.cmd.colorscheme("catppuccin")
vim.cmd.highlight("Normal guibg=#101019")

require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "gopls", "rust_analyzer", "pyright",
                         "clangd" },
})

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true)
            }
        }
    }
})

require("flutter-tools").setup({ fvm = true })

require("nvim-treesitter.configs").setup({
    ensure_installed = { "c", "lua", "markdown", "markdown_inline", "go",
                         "rust", "python" },
    sync_install = false,
    auto_install = true,
    modules = {},
    ignore_install = {},
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            node_incremental = "v",
            scope_incremental = "<C-s>",
            node_decremental = "V",
        },
    },
})

vim.keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>")
vim.keymap.set("n", "<C-j>", ":TmuxNavigateDown<CR>")
vim.keymap.set("n", "<C-k>", ":TmuxNavigateUp<CR>")
vim.keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>")
vim.keymap.set("n", "<C-\\>", ":TmuxNavigatePrevious<CR>")

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function()
        vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
        vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition)
    end,
})

vim.keymap.set("n", "<leader>sf", ":FzfLua files<CR>",
               { desc = "Find Files" })
vim.keymap.set("n", "<leader>sg", ":FzfLua live_grep<CR>",
               { desc = "Live Grep" })
