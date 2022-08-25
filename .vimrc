" If using with neovim and this vimrc is not being used, check to make sure
" your init.vim file exists (~/.config/nvim/init.vim) and points to this file as source.
"
"
"
" Current Custom Key Binds:
"
"
" \l            (List Toggle) Toggle Location List (The list at the bottom of
"                     the screen that tells you what errors you have)
" gd            (Coc) Go to Definition
" gy            (Coc) Go to type definition
" gi            (Coc) Go to implementation
" gr            (Coc) Go to references
" K             (Coc) Shows documentation for function/var/type/whatever is
"                     under your cursor in a nice little popup window.
" \rn           (Coc) Performs a rename of a variable much like you would
"                     expect from an IDE (renames a variable/function in all 
"                     occurrunces)
"
" <F5>          (Vimspector) Start/Continue Debugging
" <F3>          (Vimspector) Stop Debugging
" <F4>          (Vimspector) Restart Debugging with same configuration
" <F6>          (Vimspector) Pause Debugger
" <F9>          (Vimspector) Toggle line breakpoint or logpoint on the current
"                            line
" <F8>          (Vimspector) Add a function breakpoint for the expression
"                            under the cursor
" <F10>         (Vimspector) Step Over
" <F11>         (Vimspector) Step Into
" <F12>         (Vimspector) Step Out
" \di           (Vimspector) Balloon Eval
"
" \n            (Nerd Tree) Toggles the Nerd Tree (File Tree in left
"                                  sidebar) 
" ;f            (FZF) Runs fuzzy finder in nice little popup window.
" \t            (Tagbar) Toggles the Tagbar in the right sidebar
" \nd           (Neogen) Allows the creation of automated documentation for
"                        code. (only works in some languages)
"



" Setup plugin script and color scheme (Only runs once.)
if empty(glob('~/.vim/autoload/plug.vim'))
    if has('unix') || has('wsl') || has('mac')
        silent !curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
        silent !nvm install node
    endif
    if has('unix') || has('wsl')
        silent !sudo apt-get install curl git cmake clangd
    endif
    if has('mac')
        silent !brew install curl git cmake clangd
    endif
    silent !curl -flo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC

    if empty(glob('~/.vim/colors/sonokai.vim'))
        echom "Setting up colorscheme..."
        silent !mkdir ~/.vim/colors
        silent !cp ~/.vim/plugged/sonokai/colors/sonokai.vim ~/.vim/colors/sonokai.vim
        silent !cp ~/.vim/plugged/sonokai/autoload/sonokai.vim ~/.vim/autoload/sonokai.vim
        silent !cp ~/.vim/plugged/onedark/colors/onedark.vim ~/.vim/colors/onedark.vim
        silent !cp ~/.vim/plugged/onedark/autoload/onedark.vim ~/.vim/autoload/onedark.vim
    endif
endif

" Normal Vim settings
set nocompatible
syntax on
set ignorecase
set smartcase
set hlsearch
set incsearch
set autoindent
set ruler
set mouse=a
set tags=tags
set number
set shiftwidth=4
set tabstop=4
set smarttab
set expandtab
set nofoldenable
set sidescrolloff=5
set scrolloff=5
set wrap
set linebreak
set history=9999
set encoding=utf-8
set updatetime=100
" set omnifunc=syntaxcomplete#Complete
set termguicolors
set fillchars+=stlnc:-
set fillchars+=stl:-
if !has('nvim')
    set ttymouse=sgr
    set signcolumn=number
endif


" Normal (Not Mode. Just general not plugin or neovim specific) Remappings
nnoremap j gj
nnoremap k gk


" WSL yank support
" if has('wsl')
    " let g:clipboard = {
                " \ 'name': 'win32yank-wsl',
                " \ 'copy': {
                    " \ '+': 'win32yank.exe -i --crlf',
                    " \ '*': 'win32yank.exe -i --crlf',
                " \ },
                " \ 'paste': {
                    " \ '+': 'win32yank.exe -o --lf',
                    " \ '*': 'win32yank.exe -o --lf',
                " \ },
                " \ 'cache_enabled': 0,
            " \ }

    " let s:clip = '/mnt/c/Windows/System32/clip.exe'
    " if executable(s:clip)
        " augroup WSLYank
            " autocmd!
            " autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
        " augroup END
    " endif
" endif



" For some reason when this is turned on vim plug doesn't work.
"if filereadable("/home/viper/.vim/autoload/plug.vim")

    " Color schemes
    colorscheme sonokai
    " colorscheme onedark


    autocmd BufNew,BufRead *.s set ft=gas

    " Syntastic Settings // Deprecated and no longer used. ALE is recommended
    " instead.
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    " let g:syntastic_python_checkers = ['flake8', 'pyflakes', 'pylint']
    let g:syntastic_python_checkers = []
    let g:syntastic_quiet_messages = { "type": "style" }

    " ALE Settings
    let g:ale_disable_lsp = 0
    let g:ale_sign_column_always = 1
    let g:airline#extensions#ale#enabled = 1
    let g:ale_cache_executable_check_failures = 1

    let g:ale_open_list = 1
    let g:ale_set_loclist = 1
    let g:ale_set_quickfix = 0

    let g:ale_echo_msg_error_str = 'E'
    let g:ale_echo_msg_warning_str = 'W'
    let g:ale_echo_msg_format = '[%linter%] %code%: %s [%severity%]'

    let g:ale_python_pylint_use_msg_id = 1
    let g:ale_python_flake8_options = '--ignore=E302, E303'

    let g:ale_linters = {'cpp': ['gcc']}

    let g:ale_cpp_cc_options = '-std=c++17 -Wall'
    let g:ale_c_parse_compile_commands = 1
    " Keep in mind that the parse make file for gcc linter will not work with MinGW
    let g:ale_c_parse_makefile = 1
    let g:ale_c_build_dir_names = ['.', 'Build', 'build', 'bin']
    autocmd QuitPre * if empty(&bt) | lclose | endif

    let g:ale_pattern_options = {
                \        '.*\.asm$': {'ale_enabled': 0}
                \}


    " Valloric/List Toggle Settings
    let g:lt_location_list_toggle_map = '\l'
    let g:lt_height = 10

    " YCM Settings
    let g:ycm_show_diagnostics_ui = 0

    " COC Settings
    "
    " Note: if you are not getting autocompletion for system commands when working
    " with C/C++ code, make sure clangd is installed. Don't use the built in
    " clangd. Make sure to type `:CocCommand clangd.install` while in C/C++ file.
    if empty(glob('~/.config/nvim/coc-settings.json'))
        echom "Setting up coc-settings.json"
        silent !touch ~/.config/nvim/coc-settings.json
        silent !echo "{\n\t\"diagnostic.displayByAle\": true,\n\t\"diagnostic.enable\": true,\n\t\"clangd.path\": \"~/.config/coc/extensions/coc-clangd-data/install/12.0.0/clangd_12.0.0/bin/clangd\"\n}" > ~/.config/nvim/coc-settings.json
    endif
    let g:coc_global_extensions = ['coc-clangd', 'coc-html', 'coc-pyright', 'coc-json', 'coc-omnisharp', 'coc-sh', 'coc-tsserver', 'coc-cmake', 'coc-java', 'coc-glslx', 'coc-marketplace', 'coc-vimlsp', 'coc-emmet']
    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)
    nmap <silent> K :call <SID>show_documentation()<CR>
    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
      else
        execute '!' . &keywordprg . " " . expand('<cword>')
      endif
    endfunction
    autocmd CursorHold * silent call CocActionAsync('highlight')
    nnoremap \rn <Plug>(coc-rename)
    inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

    " Airline Settings
    let g:airline#extensions#tabline#enabled = 1
    let g:python_highlight_space_errors = 0

    " SuperTab Settings
    let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
    let g:SuperTabDefaultCompletionType = "context"

    " Vimspector Settings
    let g:vimspector_enable_mappings = 'HUMAN'
    let g:vimspector_install_gadgets = ['debugpy', 'vscode-cpptools', 'CodeLLDB', 'vscode-java-debug', 'vscode-java-language-server']
    let g:vimspector_sign_priority = {
                \ 'vimspectorBP':               997,
                \ 'vimspectorBPCond':           997,
                \ 'vimspectorBPLog':            997,
                \ 'vimspectorBPDisabled':       997,
                \ 'vimspectorPC':               998,
                \ 'vimspectorPCBP':             999,
                \ 'vimspectorCurrentThread':    997,
                \ 'vimspectorCurrentFrame':     997,
                \}
    nnoremap <F2> :VimspectorReset<CR>
    nmap \di <Plug>VimspectorBalloonEval

    " NERD Settings
    let g:NERDCreateDefaultMappings = 1
    let g:NERDSpaceDelims = 1
    let g:NERDTrimTrailingWhitespace = 1
    nnoremap \n :NERDTreeToggle<CR>

    " Fuzzy Finder Settings
    let g:fzf_preview_window = ['right:50%', 'ctrl-/']
    nnoremap ;f :Files<CR>

    " Tagbar Settings
    autocmd vimenter * Tagbar
    nnoremap \t :TagbarToggle<CR>

    " Polyglot Settings
    let g:polyglot_disabled = ['autoindent']

    " GitGutter Settings
    highlight GitGutterAdd guifg=#00ff00 ctermfg=2 ctermbg=236
    highlight GitGutterDelete guifg=#ff0000 ctermfg=1 ctermbg=236
    highlight GitGutterChange guifg=#ffff00 ctermfg=3 ctermbg=236
    highlight linenr ctermfg=8 ctermbg=16
    set colorcolumn=80
    highlight ColorColumn ctermbg=0 guibg=#4C4F5A
    autocmd vimenter * GitGutterEnable
    autocmd BufWritePost * GitGutter

    " tmux settings
    " If you want proper interaction between tmux and vim/neovim make sure to have
    " your tmux.conf look like what is provided at
    " https://github.com/christoomey/vim-tmux-navigator#tmux



    " NOTE: Treesitter Settings at bottom of file

    call plug#begin('~/.vim/plugged')
    if has('nvim-0.5')
        Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
        Plug 'danymat/neogen'
    endif
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'dense-analysis/ale'
    Plug 'sheerun/vim-polyglot'
    Plug 'jiangmiao/auto-pairs'
    Plug 'Valloric/ListToggle'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'tmhedberg/simpylfold'
    Plug 'airblade/vim-gitgutter'
    Plug 'ryanoasis/vim-devicons'
    Plug 'vim-airline/vim-airline'
    Plug 'preservim/nerdtree'
    Plug 'preservim/nerdcommenter'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'habamax/vim-asciidoctor'
    Plug 'https://github.com/ervandew/supertab.git'
    Plug 'puremourning/vimspector'
    Plug 'preservim/tagbar'
    Plug 'Yggdroot/indentLine'
    Plug 'tpope/vim-surround'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
    Plug 'junegunn/fzf.vim'
    Plug 'christoomey/vim-tmux-navigator'

    if has('nvim-0.6')
        Plug 'stevearc/dressing.nvim'
    endif

    " Color Themes
    Plug 'Shirk/vim-gas'
    Plug 'sainnhe/sonokai'
    Plug 'joshdick/onedark.vim'

    call plug#end()



    " Ensures that the editor is neovim and version greater than 0.5 to use lua
    " and related plugins.
    if has('nvim-0.5')

lua << EOF
require('neogen').setup {
    enabled = true
}
require('nvim-treesitter.configs').setup { 
    ensure_installed = {"cmake", "python", "lua", "json", "cpp", "java", "javascript", "css", "c", "jsdoc", "make", "markdown", "html", "typescript", "ruby", "rust", "vim", "bash", "c_sharp"}, 
    highlight = { enable = true } 
}

-- Neogen Settings
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "\\nd", ":lua require('neogen').generate()<CR>", opts)


EOF

    endif

"endif
