return {
    {
        "danymat/neogen",
        config = function()
            require('neogen').setup {
            enabled = true
            }
            local opts = { noremap = true, silent = true }
            vim.api.nvim_set_keymap("n", "<leader>nd", ":lua require('neogen').generate()<CR>", opts)

        end
    },
}
