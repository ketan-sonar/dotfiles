return {
    "rebelot/kanagawa.nvim",
    enabled = false,
    config = function()
        require("kanagawa").setup({
            keywordStyle = { italic = false, bold = true },
            typeStyle = { bold = true },
        })
        vim.cmd("colorscheme kanagawa-dragon")
    end,
}
