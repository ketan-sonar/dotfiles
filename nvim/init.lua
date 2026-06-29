vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.signcolumn = "yes"
vim.opt.winborder = "rounded"
-- vim.opt.colorcolumn = "80"
-- vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undodir"
vim.opt.undofile = true
vim.opt.scrolloff = 4
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.listchars = { tab = "» ", space = "·", nbsp = "␣" }
vim.opt.path:append("**")
vim.opt.wildignore:append("*/node_modules/*")
vim.opt.wildignore:append("*/target/*")
vim.opt.iskeyword:remove("_")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim"
    local out = vim.fn.system({ "git", "clone", "--depth=1", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
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

require("lazy").setup({
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                transparent_background = true,
                integrations = { nvimtree = true },
            })
            vim.cmd.colorscheme("catppuccin-mocha")
        end,
    },

    { "m00qek/baleia.nvim" },
    { "rachartier/tiny-inline-diagnostic.nvim" },
    { "nvim-mini/mini.nvim" },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-mini/mini.nvim" },
        config = function()
            require("lualine").setup({
                options = {
                    globalstatus = true,
                    component_separators = "",
                    section_separators = { left = "", right = "" },
                },
                sections = {
                    lualine_a = {
                        { "mode", separator = { left = "", right = "" }, right_padding = 2 },
                    },
                    lualine_b = {
                        { "branch", icon = "" },
                        "diagnostics",
                    },
                    lualine_c = { "filename" },
                    lualine_x = { "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = {
                        { "location", separator = { left = "", right = "" }, left_padding = 2 },
                    },
                },
            })
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        config = function()
            require("nvim-treesitter").setup()

            ---@param buf integer
            ---@param language string
            local function treesitter_try_attach(buf, language)
                -- Check if a parser exists and load it
                if not vim.treesitter.language.add(language) then return end
                -- Enable syntax highlighting and other treesitter features
                vim.treesitter.start(buf, language)

                -- Enable treesitter based folds
                -- For more info on folds see `:help folds`
                -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                -- vim.wo.foldmethod = 'expr'

                -- Check if treesitter indentation is available for this language, and if so enable it
                -- in case there is no indent query, the indentexpr will fallback to the vim's built in one
                local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil

                -- Enable treesitter based indentation
                if has_indent_query then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
            end

            local available_parsers = require('nvim-treesitter').get_available()
            vim.api.nvim_create_autocmd('FileType', {
                callback = function(args)
                    local buf, filetype = args.buf, args.match

                    local language = vim.treesitter.language.get_lang(filetype)
                    if not language then return end

                    local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

                    if vim.tbl_contains(installed_parsers, language) then
                        -- Enable the parser if it is already installed
                        treesitter_try_attach(buf, language)
                    elseif vim.tbl_contains(available_parsers, language) then
                        -- If a parser is available in `nvim-treesitter`, auto-install it and enable it after the installation is done
                        require('nvim-treesitter').install(language):await(function() treesitter_try_attach(buf, language) end)
                    else
                        -- Try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
                        treesitter_try_attach(buf, language)
                    end
                end,
            })
        end
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
            "folke/lazydev.nvim",
        },
    },

    {
        "saghen/blink.cmp",
        version = "v1.*",
        dependencies = { "rafamadriz/friendly-snippets" },
    },

    { "lewis6991/gitsigns.nvim" },
    {
        "neogitorg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "ibhagwan/fzf-lua",
        },
    },

    { "christoomey/vim-tmux-navigator" },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-mini/mini.nvim" },
    },

    { "linux-cultist/venv-selector.nvim" },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-mini/mini.nvim",
        },
    },
})

require("mason").setup()
require("mason-lspconfig").setup()
require("lazydev").setup()

vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)

require("blink.cmp").setup({
    fuzzy = { implementation = "prefer_rust" },
    keymap = { preset = "super-tab" },
})

require("tiny-inline-diagnostic").setup()

require("venv-selector").setup()
vim.keymap.set("n", "<leader>v", ":VenvSelect<CR>")

require("gitsigns").setup()

require("mini.icons").setup()
require("mini.icons").mock_nvim_web_devicons()
require("mini.pairs").setup()
require("mini.surround").setup()

require("nvim-tree").setup({
    view = { width = 40, side = "right", adaptive_size = true },
})
vim.keymap.set("n", "<leader>f", ":NvimTreeToggle<CR>")

vim.keymap.set("n", "<leader>m", ":make<CR>")
vim.keymap.set("n", "<leader>j", ":cnext<CR>")
vim.keymap.set("n", "<leader>k", ":cprev<CR>")

vim.keymap.set("n", "<leader>o", ":update<CR>:source<CR>")
vim.keymap.set("n", "<leader>w", ":update<CR>")
vim.keymap.set("n", "<leader>q", ":quit<CR>")

vim.keymap.set("v", "<C-y>", '"+y')
vim.keymap.set("n", "<C-p>", '"+p')
vim.keymap.set("v", "<C-p>", '"+P')

vim.keymap.set("n", "<leader>sf", ":FzfLua files<CR>")
vim.keymap.set("n", "<leader>sg", ":FzfLua live_grep<CR>")
vim.keymap.set("n", "<leader>sb", ":FzfLua buffers<CR>")
vim.keymap.set("n", "<leader>sm", ":FzfLua manpages<CR>")

vim.keymap.set("n", "<leader>g", ":Neogit<CR>")

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
