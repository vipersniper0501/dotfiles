-- If using with neovim and this vimrc is not being used, check to make sure 
-- your init.vim file exists (~/.config/nvim/init.vim) and points to this file 
-- as source.
--
-- Current Custom Key Binds:
--
-- <leader> = ;
--
-- <CR>                 (Coc) Command Completion
-- gd                   (Coc) Go to Definition
-- gy                   (Coc) Go to type definition
-- gi                   (Coc) Go to implementation
-- gr                   (Coc) Go to references
-- K                    (Coc) Shows documentation for function/var/type/whatever is
--                            under your cursor in a nice little popup window. Note
--                            hat the K key mapping is Shift-k if that wasn't clear.
-- <leader>rn           (Coc) Performs a rename of a variable much like you would
--                            expect from an IDE (renames a variable/function in all 
--                            occurrunces)
--
-- <F2>                 (Vimspector) Quit Debugging (VimspectorReset)
-- <F3>                 (Vimspector) Stop Debugging (VimspectorStop)
-- <F4>                 (Vimspector) Restart Debugging with same configuration
-- <F5>                 (Vimspector) Start/Continue Debugging
-- <F6>                 (Vimspector) Pause Debugger
-- <F8>                 (Vimspector) Add a *function* breakpoint for the expression
--                                   under the cursor
-- <F9>                 (Vimspector) Toggle _line_ breakpoint or logpoint on the current
--                                   line
-- <F10>                (Vimspector) Step Over
-- <F11>                (Vimspector) Step Into
-- <F12>                (Vimspector) Step Out
-- <leader>di           (Vimspector) Balloon Eval
--
-- <leader>n            (Neotree) Toggles the Nerd Tree (File Tree in left
--                                  sidebar) 
--
-- <leader>ff           (FZF) Runs fuzzy finder in nice little popup window.
-- 
-- <leader>tb           (Vista) Toggles the Tagbar in the right sidebar
--
-- <leader>tt           (Todo-comments) Using Telescope, search through todos
-- <leader>lt           (Todo-comments) Using Telescope, search through todos
--
-- <leader>nd           (Neogen) Allows the creation of automated documentation for
--                        code. (only works in some languages)
--

vim.g.mapleader = ";"

local o = vim.opt
local keyset = vim.api.nvim_set_keymap


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
o.updatetime = 100
o.omnifunc = "syntaxcomplete#Complete"
o.termguicolors = true
o.list = true
o.swapfile = false
-- o.ttymouse = "sgr"
o.signcolumn = "number"


vim.api.nvim_set_option_value("colorcolumn", "80", {})

-- bootstrap lazyvim
-- Note that lazyvim stores all files in: ~/.local/share/nvim/lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
       "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
    vim.fn.system(
    "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash"
    )
end
vim.opt.rtp:prepend(lazypath)


plugins = {
    "christoomey/vim-tmux-navigator",
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    "danymat/neogen",
    "stevearc/dressing.nvim",
    "JoosepAlviste/nvim-ts-context-commentstring",
    "nvim-treesitter/nvim-treesitter-context",
    -- "jiangmiao/auto-pairs",
    {
        "folke/todo-comments.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            'nvim-telescope/telescope.nvim',
        },
        opts = {
            -- None right now. Defaults are pretty good
        }
    },
    "Valloric/ListToggle",
    "airblade/vim-gitgutter",
    "ryanoasis/vim-devicons",
    "vim-airline/vim-airline",
    -- {"preservim/nerdtree", lazy = true},
    {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            --"3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        }
    },
    "preservim/nerdcommenter",
    "Xuyuanp/nerdtree-git-plugin",
    {"habamax/vim-asciidoctor", ft = {"adoc", "asciidoc"}},
    {"puremourning/vimspector"},
    "liuchengxu/vista.vim",
    "nvim-lua/plenary.nvim",
    "tpope/vim-surround",
    "tpope/vim-fugitive",
    {"lukas-reineke/indent-blankline.nvim", main = "ibl"},
    -- {"junegunn/fzf", build = ":call fzf#install()"},
    -- "junegunn/fzf.vim",
    "rcarriga/nvim-notify",
    {
    'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    -- Colorscheme
    {"sainnhe/sonokai",
        lazy = false,
        priority = 1000, -- Make sure to load this first (default for everything else is 50)
        config = function()
            -- Load Colorscheme here
            vim.g.sonokai_diagnostic_virtual_text = 'colored'
            vim.g.sonokai_better_performance = 0
            vim.cmd([[colorscheme sonokai]])
        end
    },

    -- Conqueror of Completion -- Mainly uses node as backend
    {"neoclide/coc.nvim",
        branch = "release"
    },
}

-- Options for Lazy nvim
local lazy_opts = {
    ui = {
        border = "double",
        size = {
            width = 0.8,
            height = 0.8
        }
    }
}

require("lazy").setup(plugins, lazy_opts)


--
-- Plugin Settings
--

require("coc")

-- Normal Mode Settings
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true })

-- Valloric/List Toggle Settings
vim.g.lt_location_list_toggle_map = "<leader>l"
vim.g.lt_height = 10


-- Vimspector Settings

-- vim.g.vimspector_enable_mappings = "HUMAN"
vim.g.vimspector_install_gadgets = {
    "debugpy", "vscode-cpptools", "CodeLLDB", "vscode-java-debug", "vscode-java-language-server"
}

vim.g.vimscpector_sign_priority = {
    vimspectorBP =              997,
    vimspectorBPCond =          997,
    vimspectorBPLog =           997,
    vimspectorBPDisabled =      997,
    vimspectorPC =              998,
    vimspectorPCBP =            999,
    vimspectorCurrentThread =   997,
    vimspectorCurrentFrame =    997
}

keyset("n", "<F2>", ":VimspectorReset<CR>", {noremap = true})
keyset("n", "<F3>", "<Plug>VimspectorStop", {noremap = true})
keyset("n", "<F4>", "<Plug>VimspectorRestart", {noremap = true})
keyset("n", "<F5>", "<Plug>VimspectorContinue", {noremap = true})
keyset("n", "<F6>", "<Plug>VimspectorPause", {noremap = true})
keyset("n", "<F8>", "<Plug>VimspectorAddFunctionBreakpoint", {noremap = true})
keyset("n", "<F9>", "<Plug>VimspectorToggleBreakpoint", {noremap = true})
keyset("n", "<leader><F9>", "<Plug>VimspectorDisassemble", {noremap = true})
keyset("n", "<F10>", "<Plug>VimspectorStepOver", {noremap = true})
keyset("n", "<F11>", "<Plug>VimspectorStepInto", {noremap = true})
keyset("n", "<F12>", "<Plug>VimspectorStepOut", {noremap = true})

keyset("n", "<leader>di", "<Plug>VimspectorBalloonEval", {})

-- NERD Tree Settings

vim.g.NERDCreateDefaultMappings = 1
vim.g.NERDSpaceDelims = 1
vim.g.NERDTrimTrailingWhitespace = 1
-- keyset("n", "<leader>n", ":NERDTreeToggle<CR>", {})


-- Neotree Settings
keyset("n", "<leader>n", ":Neotree reveal toggle<CR>", {})
require("neo-tree").setup({
    source_selector = {
        winbar = true
    }
})

-- Fuzzy Finder Settings
vim.g.fzf_preview_window = {
    "right:50%", "ctrl-/"
}

-- keyset("n", "<leader>f", ":Files<CR>", {noremap = true})

-- Telescope Settings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Vista Settings (tagbar replacement)
keyset("n", "<leader>tb", ":Vista!!<CR>", {noremap = true})

-- GitGutter Settings
vim.api.nvim_create_autocmd("VimEnter", {
    command = "GitGutterEnable"
})
vim.api.nvim_create_autocmd("BufWritePost", {
    command = "GitGutter"
})
vim.g.gitgutter_sign_priority = 0

-- Neogen Settings
require('neogen').setup {
enabled = true
}

-- Treesitter Settings
require('nvim-treesitter.configs').setup {
ensure_installed = {"cmake", "python", "json", "cpp", "java", "javascript",
                    "css", "c", "jsdoc", "make", "markdown", "html",
                    "typescript", "tsx", "ruby", "rust", "vim", "bash",
                    "c_sharp", "scss", "go", "lua"},
highlight = { enable = true },
indent = {enable = true}
}

-- require('ts_context_commentstring').setup {
--   enable_autocmd = false,
-- }

require('treesitter-context').setup{
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
}

-- Required for version 3 of indent-blankline
require('ibl').setup({
    indent = {
        char = "¦"
    }
})

-- Neogen Settings
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<leader>nd", ":lua require('neogen').generate()<CR>", opts)

vim.g.airline_highlighting_cache = 1

-- Todo Settings
vim.api.nvim_set_keymap("n", "<leader>tt", ":TodoTelescope<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>tl", ":TodoLocList<CR>", {noremap = true})

-- notification settings
vim.notify = require("notify")


-- Custom Highlighting

vim.cmd([[highlight CocErrorHighlight cterm=underline ctermfg=1 gui=undercurl guibg=#D05A42 guisp=#FF0000]])
vim.cmd([[highlight CocWarningHighlight cterm=underline ctermfg=1 gui=undercurl guibg=#D05A42 guisp=#FF0000]])

