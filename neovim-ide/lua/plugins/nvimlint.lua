return {
  "mfussenegger/nvim-lint",
  opts = {},
  config = function()
    vim.env.ESLINT_D_PPID = vim.fn.getpid()
    local linter = require("lint")
    linter.linter_by_ft = {
      dart = { "dcm" },
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
    }
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        linter.try_lint()
      end
    })
  end
}
