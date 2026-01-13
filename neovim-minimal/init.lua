vim.opt.termguicolors = true
vim.opt.cursorline = true
-- vim.opt.guicursor = ""

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

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
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
			"nvim-treesitter/nvim-treesitter",
			branch = "master",
			lazy = false,
			build = ":TSUpdate",
			config = function()
				require("nvim-treesitter.configs").setup({
					ensure_installed = {},
					sync_install = false,
					auto_install = true,
					modules = {},
					ignore_install = {},
					highlight = { enable = true },
					incremental_selection = {
						enable = true,
						keymaps = {
							node_incremental = "v",
							scope_incremental = "<C-s>",
							node_decremental = "V",
						},
					},
					indent = { enable = true },
				})
			end,
		},
		{
			"catppuccin/nvim",
			name = "catppuccin",
			priority = 1000,
			---@module "catppuccin"
			---@type CatppuccinOptions
			opts = {
				flavour = "mocha",
				no_italic = true,
				no_bold = true,
				color_overrides = { mocha = { base = "#101019" } },
			},
			config = function(_, opts)
				require("catppuccin").setup(opts)
				vim.cmd.colorscheme("catppuccin")
			end,
		},
		{
			"neovim/nvim-lspconfig",
			dependencies = {
				{
					"folke/lazydev.nvim",
					ft = "lua",
					dependencies = {
						{
							"DrKJeff16/wezterm-types",
							lazy = true,
							version = false,
						},
					},
					opts = {
						library = {
							{
								path = "${3rd}/luv/library",
								words = { "vim%.uv" },
							},
							{
								path = "wezterm-types",
								mods = { "wezterm" },
							},
						},
					},
				},
			},
		},
		{ "mason-org/mason.nvim", opts = {} },
		{
			"mason-org/mason-lspconfig.nvim",
			opts = {},
			dependencies = {
				{ "mason-org/mason.nvim", opts = {} },
				"neovim/nvim-lspconfig",
			},
		},
		{
			"rachartier/tiny-inline-diagnostic.nvim",
			event = "VeryLazy",
			priority = 1000,
			opts = {},
		},
		{
			"saghen/blink.cmp",
			dependencies = { "rafamadriz/friendly-snippets" },
			version = "1.*",
			---@module "blink-cmp"
			---@type blink.cmp.Config
			opts = {
				keymap = { preset = "super-tab" },
				signature = { enabled = true },
			},
			opts_extend = { "sources.default" },
		},
		{
			"stevearc/conform.nvim",
			opts = {
				formatters_by_ft = {
					lua = { "stylua" },
					python = {
						"ruff_fix",
						"ruff_format",
						"ruff_organize_imports",
					},
					rust = { "rustfmt", lsp_format = "fallback" },
					javascript = { "prettierd" },
					javascriptreact = { "prettierd" },
					typescript = { "prettierd" },
					typescriptreact = { "prettierd" },
					go = { "gofmt", "goimports", "golines" },
				},
			},
			config = function(_, opts)
				local conform = require("conform")
				conform.setup(opts)
				vim.keymap.set("n", "<leader>cf", conform.format)
			end,
		},
		{ "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
		{
			"christoomey/vim-tmux-navigator",
			cmd = {
				"TmuxNavigateLeft",
				"TmuxNavigateDown",
				"TmuxNavigateUp",
				"TmuxNavigateRight",
				"TmuxNavigatePrevious",
				"TmuxNavigatorProcessList",
			},
			keys = {
				{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
				{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
				{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
				{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
				{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
			},
		},
		{
			"ibhagwan/fzf-lua",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			config = function()
				vim.keymap.set("n", "<leader>sf", ":FzfLua files<CR>")
				vim.keymap.set("n", "<leader>sg", ":FzfLua live_grep<CR>")
			end,
		},
		{
			"stevearc/oil.nvim",
			---@module 'oil'
			---@type oil.SetupOpts
			opts = {},
			dependencies = { "nvim-tree/nvim-web-devicons" },
			lazy = false,
            config = function(_, opts)
				local oil = require("oil")
				oil.setup(opts)
				vim.keymap.set("n", "-", ":Oil<CR>")
            end
		},
	},
	install = { colorscheme = { "habamax" } },
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function()
		vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
		vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition)
	end,
})

vim.keymap.set("n", "<leader>m", ":make<CR>")
vim.keymap.set("n", "<leader>j", ":cnext<CR>")
vim.keymap.set("n", "<leader>k", ":cprev<CR>")

vim.keymap.set("n", "<leader>o", ":update<CR>:source<CR>")
vim.keymap.set("n", "<leader>w", ":update<CR>")
vim.keymap.set("n", "<leader>q", ":quit<CR>")
