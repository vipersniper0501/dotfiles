
local o = vim.opt

vim.g.mapleader = ";"
o.compatible = false
o.syntax = "on"
o.ignorecase = true
o.smartcase = true
o.hlsearch = true
o.autoindent = true
o.ruler = true
o.mouse = "a"
o.tags = "tags"
o.number = true
o.shiftwidth = 4
o.tabstop = 4
o.smarttab = true
o.expandtab = true
o.foldenable = false
o.sidescrolloff = 5
o.scrolloff = 5
o.wrap = true
o.linebreak = true
o.history = 9999
o.encoding = "utf-8"
o.updatetime = 10
o.omnifunc = "syntaxcomplete#Complete"
o.termguicolors = true
o.list = true
o.swapfile = false
-- o.ttymouse = "sgr"
-- Spellcheck
o.spell = true
o.spelllang = "en_us"
o.signcolumn = "number"
o.completeopt = {'menu', 'menuone', 'noselect'}
vim.api.nvim_set_option_value("colorcolumn", "80", {})

vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true })
vim.api.nvim_set_keymap('n', '<esc>', '<esc>:noh<cr>', { noremap = true, silent = true })

