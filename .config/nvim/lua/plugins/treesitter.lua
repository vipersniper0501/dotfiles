return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local treesitter = require("nvim-treesitter.configs")

            treesitter.setup({
                    ensure_installed = {"cmake", "python", "cpp", "java",
                        "javascript", "css", "c", "jsdoc", "make", "markdown",
                        "html", "typescript", "tsx", "ruby", "rust", "vim", "bash",
                        "c_sharp", "scss", "lua", "r", "json", "json5", "jsonc", "http",
                        "go", "gomod", "gosum", "gotmpl", "glsl", "gitignore",
                        "git_config", "gitcommit", "git_rebase", "doxygen",
                        "comment", "c_sharp", "angular", "astro", "awk", "cuda", "dart",
                        "dockerfile", "kotlin", "luadoc", "nim", "nix", "ocaml", "proto",
                        "sql", "ssh_config", "vue", "wgsl", "wgsl_bevy", "xml", "yaml", "zig"
                    },
                    sync_install = false,
                    auto_install = true,
                    ignore_install = {},
                    highlight = {
                        enable = true
                    },
                    indent = {
                        enable = true
                    },
                    dependencies = {
                        "windwp/nvim-ts-autotag",
                    },
                    autotag = {
                        enable = true
                    }

                }
            )
        end
    },
}
