return {
    "thimc/gruber-darker.nvim",
    priority = 1000,
    opts = {
        -- transparent = true, -- removes the background
        -- underline = false, -- disables underline fonts
        -- bold = false, -- disables bold fonts
    },
    config = function()
        vim.cmd.colorscheme("gruber-darker")
    end,
}
