return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local treesitter = require("nvim-treesitter.configs")

            treesitter.setup(
                {
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
                    highlight = { enable = true },
                    indent = {enable = true},
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
    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            require('treesitter-context').setup({
              enable = false, -- Enable this plugin (Can be enabled/disabled later via commands)
              max_lines = 1, -- How many lines the window should span. Values <= 0 mean no limit.
              min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit. 
              line_numbers = true,
              multiline_threshold = 20, -- Maximum number of lines to show for a single context
              trim_scope = 'inner', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
              mode = 'topline',  -- Line used to calculate context. Choices: 'cursor', 'topline'
              -- Separator between context and content. Should be a single character string, like '-'.
              -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
              separator = nil,
              zindex = 20, -- The Z-index of the context window
              on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
            })
        end
    },
}
