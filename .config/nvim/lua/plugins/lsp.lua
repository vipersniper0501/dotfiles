return {
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()

            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                on_init = function(client)
                  if client.workspace_folders then
                    local path = client.workspace_folders[1].name
                    if vim.uv.fs_stat(path..'/.luarc.json') or vim.uv.fs_stat(path..'/.luarc.jsonc') then
                      return
                    end
                  end
              
                  client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                    runtime = {
                      -- Tell the language server which version of Lua you're using
                      -- (most likely LuaJIT in the case of Neovim)
                      version = 'LuaJIT'
                    },
                    -- Make the server aware of Neovim runtime files
                    workspace = {
                      checkThirdParty = false,
                      library = {
                        vim.env.VIMRUNTIME
                        -- Depending on the usage, you might want to add additional paths here.
                        -- "${3rd}/luv/library"
                        -- "${3rd}/busted/library",
                      }
                      -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
                      -- library = vim.api.nvim_get_runtime_file("", true)
                    }
                  })
                end,
                settings = {
                  Lua = {}
                }
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
                    vim.api.nvim_command("Lspsaga hover_doc")
                end
            end

            vim.keymap.set("n", "K",  _G.show_docs, {noremap = true, silent = true})
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
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "onsails/lspkind.nvim",
    {
        "hrsh7th/nvim-cmp",
        config = function()

            local cmp = require("cmp")
            local select_opts = { behavior = cmp.SelectBehavior.Select }
            local compare = cmp.config.compare


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
                    {name = "path", priority = 99},
                    {name = "buffer", priority = 98},
                    {name = "nvim_lsp_signature_help", priority = 97}

                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                completion = { completeopt = 'menu,menuone,noinsert,noselect' },
                preselect = cmp.PreselectMode.None,
                formatting = {
                    fields = {'abbr', 'kind', 'menu'},
                    format = function(entry, vim_item)
                        local item_with_kind = require("lspkind").cmp_format({
                            mode = "symbol_text",
                            maxwidth = 50
                        })(entry, vim_item)

                        local completion_context = get_lsp_completion_context(entry.completion_item, entry.source)
                        if completion_context ~= nil and completion_context ~= "" then
                            item_with_kind.menu = item_with_kind.menu .. completion_context
                        end

                        return item_with_kind
                    end
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
