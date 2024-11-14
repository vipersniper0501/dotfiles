return {
    -- Colorscheme
    {"sainnhe/sonokai",
        lazy = false,
        priority = 1000, -- Make sure to load this first (default for everything else is 50)
        config = function()
            -- Load Colorscheme here
            vim.g.sonokai_diagnostic_virtual_text = 'colored'
            vim.g.sonokai_better_performance = 0
            vim.cmd([[colorscheme sonokai]])
        end
    }
}
