return {
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = { "lua_ls", "rust_analyzer", "clangd",
                    "pyright", "gopls", "ts_ls", "zls", "vimls", "volar",
                    "glsl_analyzer", "rnix", "jdtls", "stylua", "checkmake",
                    "ansible-lint", "cmakelint", "roslyn", "bashls",
                    "ansible-language-server", "r-languageserver", "svelte-language-server"},
                run_on_start = true,
            })
        end
    },
    {
        "mason-org/mason.nvim",
        config = function()
            require("mason").setup({
                registries = {
                    "github:mason-org/mason-registry", -- official registry
                    "github:Crashdummyy/mason-registry", -- used for Roslyn LSP
                }
            })
            local registry = require("mason-registry")
            registry.refresh()
        end
    },
    {
        "mason-org/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup()
        end
    },
}
