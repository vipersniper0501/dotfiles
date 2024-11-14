return {
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()

            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            lspconfig.lua_ls.setup({
                capabilities = capabilities
            })
            lspconfig.rust_analyzer.setup({
                capabilities = capabilities
            })
            lspconfig.clangd.setup({
                capabilities = capabilities
            })
            lspconfig.pyright.setup({
                capabilities = capabilities
            })
            lspconfig.ts_ls.setup({
                capabilities = capabilities
            })
            lspconfig.zls.setup({
                capabilities = capabilities
            })
            lspconfig.vimls.setup({
                capabilities = capabilities
            })
            lspconfig.volar.setup({
                capabilities = capabilities
            })
            lspconfig.glsl_analyzer.setup({
                capabilities = capabilities
            })
            lspconfig.rnix.setup({
                capabilities = capabilities
            })
            lspconfig.jdtls.setup({
                capabilities = capabilities
            })
            -- Other gneral lsp config settings
            vim.diagnostic.config({
              virtual_text = false,
              severity_sort = true,
              float = {
                border = 'rounded',
                source = 'always',
              },
            })

            -- Set borders around popup windows
            local _border = "single"

            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
              vim.lsp.handlers.hover, {
                border = _border
              }
            )

            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
              vim.lsp.handlers.signature_help, {
                border = _border
              }
            )

            vim.diagnostic.config{
              float={border=_border}
            }


            _G.shift_k_enabled = false
            vim.api.nvim_create_augroup("LspGroup", {})

            vim.api.nvim_create_autocmd("CursorHold", {
                group = "LspGroup",
                callback = function()
                    if not _G.shift_k_enabled then
                        -- vim.api.nvim_command(vim.diagnostic.open_float())
                        vim.diagnostic.open_float(0, {
                            scope = "cursor",
                            focusable = false,
                            close_events = {
                                "CursorMoved",
                                "CursorMovedI",
                                "BufHidden",
                                "InsertCharPre",
                                "WinLeave",
                              },
                        })
                    end
                end,
                desc = "Show diagnostic error info on CursorHold"
            })

            vim.api.nvim_create_autocmd({"CursorMoved", "BufEnter"}, {
                callback = function()
                    _G.shift_k_enabled = false
                end
            })


            function _G.show_docs()
                _G.shift_k_enabled = true
                local cw = vim.fn.expand('<cword>')
                if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
                    vim.api.nvim_command('h ' .. cw)
                else
                    -- vim.lsp.buf.hover()
                    require("hover").hover()
                end
            end

            vim.keymap.set("n", "K",  _G.show_docs, {silent = true})
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {silent = true})
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, {silent = true})
            vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, {silent = true})
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {silent = true})
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {silent = true})
        end
    },
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    {
        "hrsh7th/nvim-cmp",
        config = function()

            local cmp = require("cmp")
            local select_opts = { behavior = cmp.SelectBehavior.Select }
            local compare = cmp.config.compare
            cmp.setup({
                sources = {
                    {name = "nvim_lsp", keyword_length = 1, priority = 3},
                    {name = "path", priority = 2},
                    {name = "buffer", keyword_length = 3, priority = 1},

                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                    scrollbar = '║'
                },
                completion = { completeopt = 'menu,menuone,noinsert,noselect' },
                preselect = cmp.PreselectMode.None,
                formatting = {
                    fields = {'menu', 'abbr', 'kind'},
                    format = function(entry, vim_item)
                        -- Source
                        vim_item.menu = ({
                            buffer = "[Buffer]",
                            nvim_lsp = "[LSP]",
                            luasnip = "[LuaSnip]",
                            nvim_lua = "[Lua]",
                            latex_symbols = "[LaTeX]",
                        })[entry.source.name]
                        return vim_item
                    end
                    -- format = lspkind.cmp_format({
                        -- mode = "symbol_text",
                        -- menu = ({
                            -- buffer = "[Buffer]",
                            -- nvim_lsp = "[LSP]",
                        -- })
                    -- })
                },
                mapping = {
                    ["<CR>"] = cmp.mapping.confirm({select = true}),
                    ["<Tab>"] = cmp.mapping.select_next_item(select_opts),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(select_opts),
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                },
                sorting = {
                    priority_weight = 1.0,
                    comparators = {
                      -- compare.score_offset, -- not good at all
                      compare.locality,
                      compare.recently_used,
                      compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
                      compare.offset,
                      compare.order,
                      -- compare.scopes, -- what?
                      -- compare.sort_text,
                      -- compare.exact,
                      -- compare.kind,
                      -- compare.length, -- useless 
                    },
                },
            })

            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            }),
            matching = { disallow_symbol_nonprefix_matching = false }
            })

            -- If you want insert `(` after select function or method item
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            cmp.event:on(
              'confirm_done',
              cmp_autopairs.on_confirm_done()
            )
            local handlers = require('nvim-autopairs.completion.handlers')

            cmp.event:on(
              'confirm_done',
              cmp_autopairs.on_confirm_done({
                filetypes = {
                  -- "*" is a alias to all filetypes
                  ["*"] = {
                    ["("] = {
                      kind = {
                        cmp.lsp.CompletionItemKind.Function,
                        cmp.lsp.CompletionItemKind.Method,
                      },
                      handler = handlers["*"]
                    }
                  },
                  lua = {
                    ["("] = {
                      kind = {
                        cmp.lsp.CompletionItemKind.Function,
                        cmp.lsp.CompletionItemKind.Method
                      },
                      ---@param char string
                      ---@param item table item completion
                      ---@param bufnr number buffer number
                      ---@param rules table
                      ---@param commit_character table<string>
                      handler = function(char, item, bufnr, rules, commit_character)
                        -- Your handler function. Inspect with print(vim.inspect{char, item, bufnr, rules, commit_character})
                      end
                    }
                  },
                  -- Disable for tex
                  tex = false
                }
              })
            )
        end
    },
}
