return {
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            -- Required for version 3 of indent-blankline
            require('ibl').setup({
                indent = {
                    char = "¦"
                }
            })
        end
    }
}
