-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    { "thimc/gruber-darker.nvim" },
    {
        "nvim-telescope/telescope.nvim", tag = "0.1.5",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    { "mbbill/undotree" },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function
    },
    {
        "numToStr/Comment.nvim",
        opts = {},
        lazy = false,
    },
    {
        "nvim-tree/nvim-tree.lua",
        opts = {},
    },
    { "nvim-tree/nvim-web-devicons" },

    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },

    { "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
    { "neovim/nvim-lspconfig" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/nvim-cmp" },
    { "L3MON4D3/LuaSnip" },
}

local opts = {}

-- setup lazy.nvim
require("lazy").setup(plugins, opts)

-- setup colorscheme
require("gruber-darker").setup({
    transparent = false, -- removes the background
    -- underline = false, -- disables underline fonts
})
vim.cmd.colorscheme("gruber-darker")

-- setup nvim-treesitter
require("nvim-treesitter.configs").setup({
    auto_install = true,
    ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query", "javascript", "typescript", "go", "rust", "python", "html" },
    highlight = { enable = true },
    indent = { enable = true },
})

-- setup nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- setup lsp_zero
local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({buffer = bufnr})
end)

require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = {},
    handlers = {
        lsp_zero.default_setup,
    },
})

local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        -- `Enter` key to confirm completion
        ["<CR>"] = cmp.mapping.confirm({select = false}),

        -- Ctrl+Space to trigger completion menu
        ["<C-Space>"] = cmp.mapping.complete(),

        -- Navigate between snippet placeholder
        ["<C-l>"] = cmp_action.luasnip_jump_forward(),
        ["<C-h>"] = cmp_action.luasnip_jump_backward(),

        -- Scroll up and down in the completion documentation
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
    }),
    completion = {
        completeopt = "menu,menuone,noinsert",
    },

})
