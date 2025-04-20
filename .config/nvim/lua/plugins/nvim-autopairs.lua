return {
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({
                check_ts = true,
                ts_config = {
                    lua = { "string" }, -- Don't add pairs in lua string treesitter nodes
                    javascript = { "template_string" }, -- Don't add pairs in JavaScript template_string treesitter nodes
                    java = false, -- Don't check treesitter on Java
                },
                disable_filetype = { "TelescopePrompt" }
            })
        end
    }
}
