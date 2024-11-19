return {
    {
    'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
        },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {noremap = true})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {noremap = true})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {noremap = true})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {noremap = true})
            require("telescope").setup {
              extensions = {
                ["ui-select"] = {
                  require("telescope.themes").get_dropdown {
                  }
                }
              }
            }
            -- To get ui-select loaded and working with telescope, you need to call
            -- load_extension, somewhere after setup function:
            require("telescope").load_extension("ui-select")
        end
    }
}
