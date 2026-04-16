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
vim.opt.colorcolumn = "80"
vim.opt.cursorline = true
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

vim.pack.add({
    { src = "https://github.com/folke/tokyonight.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
    { src = "https://github.com/folke/lazydev.nvim" },
    { src = "https://github.com/rafamadriz/friendly-snippets" },
    { src = "https://github.com/saghen/blink.cmp",                      version = vim.version.range("1.*") },
    { src = "https://github.com/rachartier/tiny-inline-diagnostic.nvim" },
    { src = "https://github.com/linux-cultist/venv-selector.nvim" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/nvim-mini/mini.nvim" },
    { src = "https://github.com/christoomey/vim-tmux-navigator" },
    { src = "https://github.com/ibhagwan/fzf-lua" },
    { src = "https://github.com/nvim-tree/nvim-tree.lua" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/sindrets/diffview.nvim" },
    { src = "https://github.com/m00qek/baleia.nvim" },
    { src = "https://github.com/neogitorg/neogit" },
    { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
})

vim.cmd.colorscheme("tokyonight-night")
vim.cmd.highlight("Normal guibg=NONE ctermbg=NONE")

vim.api.nvim_create_autocmd("FileType", {
    desc = "Automatically attach native Treesitter",
    group = vim.api.nvim_create_augroup("treesitter-auto-attach", { clear = true }),
    callback = function(args)
        if vim.bo[args.buf].buftype == "" then
            pcall(vim.treesitter.start, args.buf)
        end
    end,
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
require("mini.statusline").setup()

require("nvim-tree").setup({ view = { width = 40, side = "right" } })
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
