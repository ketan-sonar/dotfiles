return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "prettierd" },
      python = { "prettierd" },
      rust = { "rustfmt", lsp_format = "fallback" },
      javascript = { "prettierd" },
      typescript = { "prettierd" },
      dart = { "dcm" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
}
