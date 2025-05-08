return {

    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {
       "navarasu/onedark.nvim",
        priority = 1000,
        config = function()
        end
    },
    {
        "polirritmico/monokai-nightasty.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "sainnhe/sonokai",
        lazy = false,
        priority = 1000,
        config = function()
            -- Load Colorscheme here
            vim.g.sonokai_diagnostic_virtual_text = 'colored'
            vim.g.sonokai_better_performance = 0
            vim.cmd([[colorscheme sonokai]]) -- default colorscheme
        end
    }
}
