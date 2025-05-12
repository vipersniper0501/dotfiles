return {
    {
        "folke/todo-comments.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            'nvim-telescope/telescope.nvim',
        },
        opts = {
            -- None right now. Defaults are pretty good
        },
        config = function()
            vim.api.nvim_set_keymap("n", "<leader>tt", ":TodoTelescope<CR>", {noremap = true})
            vim.api.nvim_set_keymap("n", "<leader>tl", ":TodoLocList<CR>", {noremap = true})
        end
    },
}
