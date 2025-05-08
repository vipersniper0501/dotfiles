local installed_lsps = {
    "lua_ls", "rust_analyzer", "clangd",
    "pyright", "gopls", "ts_ls", "zls", "vimls", "volar",
    "glsl_analyzer", "rnix", "jdtls", "stylua", "checkmake",
    "ansible-lint", "cmakelint", "roslyn", "bashls",
    "ansible-language-server", "r-languageserver", "svelte-language-server"
}

local is_nvim_011 = vim.fn.has('nvim-0.11') == 1

return {
    {
        "mason-org/mason.nvim",
        tag = not is_nvim_011 and "v1.11.0" or nil,
        config = function()
            require("mason").setup({
                registries = {
                    "github:mason-org/mason-registry",
                    "github:Crashdummyy/mason-registry",
                }
            })
            local registry = require("mason-registry")
            registry.refresh()
        end
    },
    {
        "mason-org/mason-lspconfig.nvim",
        tag = not is_nvim_011 and "v1.32.0" or nil,
        config = function()
            if is_nvim_011 then
                require("mason-lspconfig").setup({
                    ensure_installed = installed_lsps,
                    automatic_enable = true,
                })
            else
                require("mason-lspconfig").setup()
            end
        end
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        enabled = not is_nvim_011,
        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = installed_lsps,
                run_on_start = true,
            })
        end
    }
}
