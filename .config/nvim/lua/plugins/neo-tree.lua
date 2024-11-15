return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        config = function()

            local keyset = vim.api.nvim_set_keymap
            keyset("n", "<leader>n", ":Neotree reveal toggle<CR>", {})
            require("neo-tree").setup({
                source_selector = {
                    winbar = true
                }
            })
        end
    },
}
