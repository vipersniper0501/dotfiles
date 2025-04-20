
local keyset = vim.api.nvim_set_keymap

-- CoC Settings
vim.g.coc_global_extensions = {
    'coc-clangd', 'coc-html', 'coc-pyright', 'coc-json', 'coc-omnisharp',
    'coc-sh', 'coc-tsserver', 'coc-cmake', 'coc-java', 'coc-glslx',
    'coc-marketplace', 'coc-vimlsp', 'coc-emmet', 'coc-rust-analyzer',
    'coc-java-vimspector', 'coc-angular', 'coc-scssmodules', 'coc-css',
    'coc-go', 'coc-lua', 'coc-pairs'
}

-- Coc Autocomplete
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

local coc_opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', coc_opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], coc_opts)

-- User enter to trigger completion
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], coc_opts)


-- GoTo code navigation
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})

-- Symbol renaming
keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})

_G.shift_k_enabled = false

vim.api.nvim_create_autocmd({"CursorMoved", "BufEnter"}, {
    callback = function()
        _G.shift_k_enabled = false
    end
})

-- Use K to show documentation in preview window
function _G.coc_show_docs()
    _G.shift_k_enabled = true
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end

keyset("n", "K", '<CMD>lua _G.coc_show_docs()<CR>', {silent = true})

-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})

vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    callback = function()
        if not _G.shift_k_enabled then
            vim.api.nvim_command("silent call CocActionAsync('diagnosticInfo')")
        end
    end,
    desc = "Show diagnostic error info on CursorHold"
})


keyset("n", "<leader>?", ":call CocAction('diagnosticInfo') <CR>", {noremap = true})


-- Custom Highlighting
vim.cmd([[highlight CocErrorHighlight cterm=underline ctermfg=1 gui=undercurl guibg=#D05A42 guisp=#FF0000]])
vim.cmd([[highlight CocWarningHighlight cterm=underline ctermfg=1 gui=undercurl guibg=#D05A42 guisp=#FF0000]])

