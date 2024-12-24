return {
  "marko-cerovac/material.nvim",
  enabled = true,
  config = function()
    vim.g.material_style = "deep ocean"
    vim.cmd.colorscheme("material")
  end
}
