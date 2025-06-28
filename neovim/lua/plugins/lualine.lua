return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "echasnovski/mini.icons" },
    config = function()
        require("mini.icons").setup()
        require("mini.icons").mock_nvim_web_devicons()
        require("lualine").setup({
            options = {
                component_separators = { left = "", right = ""},
                section_separators = { left = "", right = ""},
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = {
                    { "branch", icon = "" },
                    "diff",
                    "diagnostics",
                },
                lualine_c = { "filename" },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
        })
    end,
}
