return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {},
  config = function()
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>sg", builtin.git_files, { desc = "Telescope git files" })
    vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Telescope find files" })
    vim.keymap.set("n", "<leader>lg", builtin.live_grep, { desc = "Telescope live grep" })
    vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "Telescope buffers" })
    vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Telescope help tags" })
  end,
}
