return {
  "mfussenegger/nvim-lint",
  opts = {},
  config = function()
    local linter = require("lint")
    linter.linter_by_ft = {
      dart = { "dcm" },
    }
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        linter.try_lint()
      end
    })
  end
}
