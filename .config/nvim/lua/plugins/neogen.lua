return {
    {
        "danymat/neogen",
        opts = {
            enabled = true
        },
        config = function()
            require('neogen').setup {}
            local opts = { noremap = true, silent = true }
            vim.api.nvim_set_keymap("n", "<leader>nd", ":lua require('neogen').generate()<CR>", opts)
        end
    },
}
