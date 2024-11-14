return {
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = { "lua_ls", "rust_analyzer", "clangd",
                    "pyright", "ts_ls", "zls", "vimls", "volar",
                    "glsl_analyzer", "rnix", "jdtls", "stylua", "checkmake",
                    "ansible-lint", "cmakelint"},
                run_on_start = true,
            })
        end
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({})
        end
    },
}
