-- UI
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.winborder = "rounded"
vim.opt.colorcolumn = "80"

-- Editing
vim.opt.wrap = false
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.iskeyword:remove("_")

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Files
vim.opt.swapfile = false
local undodir = vim.fn.stdpath("data") .. "/undodir"
vim.fn.mkdir(undodir, "p")
vim.opt.undodir = undodir
vim.opt.undofile = true

-- Windows / scrolling
vim.opt.scrolloff = 4
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Display whitespace with :set list
vim.opt.listchars = {
    tab = "» ",
    space = "·",
    nbsp = "␣",
}

-- File searching
vim.opt.path:append("**")

for _, pattern in ipairs({
    "*/node_modules/*",
    "*/target/*",
    "*/.git/*",
    "*/dist/*",
    "*/build/*",
}) do
    vim.opt.wildignore:append(pattern)
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup({
    spec = {
        {
            "WTFox/jellybeans.nvim",
            lazy = false,
            priority = 1000,
            opts = { flat_ui = false },
            config = function(_, opts)
                require("jellybeans").setup(opts)
                vim.cmd.colorscheme("jellybeans")
            end
        },
        {
            "xiyaowong/transparent.nvim",
            lazy = false,
            priority = 1000,
            opts = {},
            config = function(_, opts)
                require("transparent").setup(opts)
                vim.cmd("TransparentEnable")
            end
        },
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
        },
        {
            "mason-org/mason-lspconfig.nvim",
            opts = {
                ensure_installed = {
                    "lua_ls", "rust_analyzer", "gopls", "clangd", "emmet_language_server", "pyright"
                },
            },
            dependencies = {
                { "mason-org/mason.nvim", opts = {} },
                "neovim/nvim-lspconfig",
            },
        },
        {
            "folke/lazydev.nvim",
            ft = "lua",
            opts = {
                library = {
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },
        {
            "saghen/blink.cmp",
            version = "1.*",
            dependencies = { "rafamadriz/friendly-snippets" },
            opts = {
                fuzzy = { implementation = "prefer_rust" },
                keymap = { preset = "super-tab" },
            },
        },
        {
            "rachartier/tiny-inline-diagnostic.nvim",
            event = "VeryLazy",
            priority = 1000,
            opts = {
                preset = "ghost",
                transparent_cursorline = true,
            },
            config = function(_, opts)
                require("tiny-inline-diagnostic").setup(opts)
                vim.diagnostic.config({ virtual_text = false })
                vim.diagnostic.open_float = require("tiny-inline-diagnostic.override").open_float
            end,
        },
        {
            "stevearc/conform.nvim",
            opts = {
                formatters_by_ft = {
                    lua = { "stylua" },
                    python = { "blue" },
                    rust = { "rustfmt" },
                    go = { "gofmt" },
                },
            },
            keys = {
                {
                    "<leader>cf",
                    function()
                        require("conform").format({
                            async = true,
                            lsp_fallback = true,
                        })
                    end,
                    desc = "Format buffer",
                },
            },
        },
        {
            "nvim-mini/mini.nvim",
            version = false,
            config = function()
                require("mini.icons").setup()
                require("mini.icons").mock_nvim_web_devicons()
                require("mini.pairs").setup()
                require("mini.surround").setup()
            end,
        },
        {
            "nvim-lualine/lualine.nvim",
            opts = {
                options = {
                    section_separators = { left = "", right = "" },
                    component_separators = { left = "", right = "" },
                },
            },
        },
        {
            "nvim-tree/nvim-tree.lua",
            lazy = false,
            opts = {
                view = { width = 40, side = "right", adaptive_size = true },
            },
            keys = {
                { "<leader>f", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" },
            },
            config = function(_, opts)
                vim.g.loaded_netrw = 1
                vim.g.loaded_netrwPlugin = 1
                require("nvim-tree").setup(opts)
            end
        },
        {
            "NeogitOrg/neogit",
            lazy = true,
            dependencies = {
                "sindrets/diffview.nvim",
                "m00qek/baleia.nvim",
            },
            cmd = "Neogit",
            keys = {
                { "<leader>g", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
            },
        },
        {
            "ibhagwan/fzf-lua",
            opts = {},
            keys = {
                { "<leader>sf", "<cmd>FzfLua files<cr>",     desc = "Find files" },
                { "<leader>sg", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
                { "<leader>sb", "<cmd>FzfLua buffers<cr>",   desc = "Find buffers" },
                { "<leader>sm", "<cmd>FzfLua manpages<cr>",  desc = "Find manpages" },
            },
        },
        { "lewis6991/gitsigns.nvim",       opts = {} },
        { "christoomey/vim-tmux-navigator" },
    },
    install = { colorscheme = { "habamax" } },
    checker = { enabled = true },
})

vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format buffer" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostics" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })

vim.keymap.set("n", "<leader>m", "<cmd>make<cr>", { desc = "Run make" })
vim.keymap.set("n", "<leader>j", "<cmd>cnext<cr>", { desc = "Next quickfix item" })
vim.keymap.set("n", "<leader>k", "<cmd>cprev<cr>", { desc = "Previous quickfix item" })

vim.keymap.set("n", "<leader>w", "<cmd>update<cr>", { desc = "Save buffer" })
vim.keymap.set("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit window" })

vim.keymap.set("v", "<C-y>", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set("n", "<C-p>", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set("v", "<C-p>", '"+P', { desc = "Paste from system clipboard" })

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>")
