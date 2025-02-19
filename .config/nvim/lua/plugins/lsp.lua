return {
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()

            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
            })
            lspconfig.rust_analyzer.setup({
                capabilities = capabilities,
                settings = {
                    ['rust-analyzer'] = {
                        diagnostics = {
                            enable = true
                        }
                    }
                }
            })
            lspconfig.clangd.setup({
                capabilities = capabilities
            })
            lspconfig.csharp_ls.setup({
                capabilities = capabilities
            })
            lspconfig.pyright.setup({
                capabilities = capabilities
            })
            lspconfig.gopls.setup({
                cmd = {'gopls', '--remote=auto'},
                filetypes = { "go", "gomod", "gowork", "gotmpl" },
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
                source = true,
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
                    vim.api.nvim_command("Lspsaga hover_doc")
                end
            end

            vim.keymap.set("n", "K",  _G.show_docs, {noremap = true, silent = true})
            vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, {noremap = true, silent = true})
            vim.keymap.set("n", "gi", require("telescope.builtin").lsp_implementations, {noremap = true, silent = true})
            vim.keymap.set('n', 'gr', require("telescope.builtin").lsp_references, {noremap = true, silent = true})
            vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, {noremap = true, silent = true})
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {noremap = true, silent = true})
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {noremap = true, silent = true})
        end
    },
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    --"hrsh7th/cmp-nvim-lsp-signature-help",
    "onsails/lspkind.nvim",
    {
        "hrsh7th/nvim-cmp",
        config = function()

            local cmp = require("cmp")
            local select_opts = { behavior = cmp.SelectBehavior.Select }

            --- Function for retrieving the import location of a completion item.
            --- i.e from what file/module are we trying to import this function/variable/method/etc
            --- from
            ---@param completion lsp.CompletionItem
            ---@param source cmp.Source
            local function get_lsp_completion_context(completion, source)
                local ok, source_name = pcall(function() return source.source.client.config.name end)
                if not ok then return nil end
                if source_name == "ts_ls" then
                    return completion.detail
                elseif source_name == "pyright" then
                    if completion.labelDetails ~= nil then
                        return completion.labelDetails.description
                elseif source_name == "rust_analyzer" then
                        return completion.detail
                elseif source_name == "zls" then
                        return completion.detail
                elseif source_name == "lua_ls" then
                        return completion.detail
                elseif source_name == "gopls" then
                        return completion.detail
                elseif source_name == "volar" then
                        return completion.detail
                elseif source_name == "clangd" then
                        local doc = completion.documentation
                        if doc == nil then return end
                        local import_str = doc.value
                        local i, j = string.find(import_str, "<.*>")
                        if i == nil then return end
                        return string.sub(import_str, i , j)
                elseif source_name == "jdtls" then
                        return completion.detail
                end
                end
            end

            cmp.setup({
                sources = {
                    {name = "nvim_lsp", priority = 100},
                    {name = "lazydev", priority = 99},
                    {name = "path", priority = 98},
                    {name = "buffer", priority = 97},
                    {name = "nvim_lsp_signature_help", priority = 96}

                },
                experimental = {
                    ghost_text = false
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                completion = { completeopt = 'menu,menuone,noselect' },
                preselect = cmp.PreselectMode.None,
                formatting = {
                    expandable_indicator = true,
                    fields = {'abbr', 'kind', 'menu'},
                    format = function(entry, vim_item)
                        local item_with_kind = require("lspkind").cmp_format({
                            mode = "symbol_text",
                            maxwidth = 50
                        })(entry, vim_item)

                        local completion_context = get_lsp_completion_context(entry.completion_item, entry.source)
                        if completion_context ~= nil and completion_context ~= "" and item_with_kind.menu ~= nil then
                            item_with_kind.menu = item_with_kind.menu .. completion_context
                        end

                        return item_with_kind
                    end
                },
                mapping = {
                    ["<CR>"] = cmp.mapping.confirm({select = false}),
                    ["<Tab>"] = cmp.mapping.select_next_item(select_opts),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(select_opts),
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                },
                sorting = {
                    priority_weight = 1.0,
                    comparators = {
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.score,

                        -- copied from cmp-under
                        function(entry1, entry2)
                            local _, entry1_under = entry1.completion_item.label:find "^_+"
                            local _, entry2_under = entry2.completion_item.label:find "^_+"
                            entry1_under = entry1_under or 0
                            entry2_under = entry2_under or 0
                            if entry1_under > entry2_under then
                                return false
                            elseif entry1_under < entry2_under then
                                return true
                            end
                        end,

                        ---kind: Entires with smaller ordinal value of 'kind' will be ranked higher.
                        ---(see lsp.CompletionItemKind enum).
                        ---Exceptions are that Text(1) will be ranked the lowest, and snippets be the highest.
                        ---@type cmp.ComparatorFunction
                        function(entry1, entry2)
                            local types = require("cmp.types")
                            local kind1 = entry1:get_kind() --- @type lsp.CompletionItemKind | number
                            local kind2 = entry2:get_kind() --- @type lsp.CompletionItemKind | number
                            kind1 = kind1 == types.lsp.CompletionItemKind.Text and 100 or kind1
                            kind2 = kind2 == types.lsp.CompletionItemKind.Text and 100 or kind2
                            if kind1 ~= kind2 then
                                -- Disable putting snippets at the top
                                --if kind1 == types.lsp.CompletionItemKind.Snippet then
                                    --return true
                                --end
                                --if kind2 == types.lsp.CompletionItemKind.Snippet then
                                    --return false
                                --end
                                local diff = kind1 - kind2
                                if diff < 0 then
                                    return true
                                elseif diff > 0 then
                                    return false
                                end
                            end
                            return nil
                        end,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
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
