vim.g.mapleader = " "

vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.wrap = false
-- vim.opt.guicursor = ""
-- vim.opt.cursorline = true
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

vim.api.nvim_set_keymap("i", "{<CR>", "{<CR>}<ESC>O", { noremap = true })
vim.api.nvim_set_keymap("i", "[<CR>", "[<CR>]<ESC>O", { noremap = true })
vim.api.nvim_set_keymap("i", "(<CR>", "(<CR>)<ESC>O", { noremap = true })

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

vim.keymap.set("n", "<leader>h", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<leader>l", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<leader>j", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<leader>k", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- quick fix list
vim.keymap.set("n", "<C-j>", "<cmd>cnext<cr>", { desc = "cnext" })
vim.keymap.set("n", "<C-k>", "<cmd>cprev<cr>", { desc = "cprev" })

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "cpp",
    callback = function()
        vim.opt_local.makeprg = "g++-15 -std=c++17 -Wall -Werror -O2 -o %< %"
    end,
})

vim.keymap.set("n", "<leader>o", ":update<CR>:source<CR>")
vim.keymap.set("n", "<leader>w", ":write<CR>")
vim.keymap.set("n", "<leader>q", ":quit<CR>")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-flutter/flutter-tools.nvim",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/vague2k/vague.nvim",
})

require("vague").setup({
    transparent = true,
    bold = false,
})

vim.cmd.colorscheme("vague")
-- vim.cmd.highlight("StatusLine guibg=NONE")
-- vim.cmd [[
--     highlight Normal guibg=none
--     highlight NormalFloat guibg=none
--     highlight NonText guibg=none
--     highlight SignColumn guibg=none
--     highlight Normal ctermbg=none
--     highlight NormalFloat ctermbg=none
--     highlight NonText ctermbg=none
--     highlight SignColumn ctermbg=none
-- ]]

require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "gopls", "rust_analyzer", "pyright" },
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

require("flutter-tools").setup({
    fvm = true,
})

require("nvim-treesitter.configs").setup({
    ensure_installed = { "c", "lua", "markdown", "markdown_inline", "go", "rust", "python" },
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

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function()
        vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
        vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition)
    end,
})
