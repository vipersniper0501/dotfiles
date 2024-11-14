return {
    {
        "liuchengxu/vista.vim",
        config = function()
            local keyset = vim.api.nvim_set_keymap
            keyset("n", "<leader>tb", ":Vista!!<CR>", {noremap = true})
        end
    }
}
