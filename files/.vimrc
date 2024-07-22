" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Add numbers to each line on the left-hand side.
set number

" Include relative line numbers
set relativenumber

" so i can see cursor
set cursorline

" Set shift width to 4 spaces.
set shiftwidth=4

" Set tab width to 4 columns.
set tabstop=4

" Use space characters instead of tabs.
set expandtab

" Do not save backup files.
set nobackup

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10

" Do not wrap lines. Allow long lines to extend as far as the line goes.
set nowrap

" mac terminal is garbage so these are needed to make coloring work better
let g:dracula_colorterm = 0
let g:dracula_italic = 0

" dracula colors
packadd! dracula
colorscheme dracula

" airline + ALE
let g:airline#extensions#ale#enabled = 1

" ALE auto completion enabled (see .vim/pack/git-plugins/start/ale)
let g:ale_completion_enabled = 1
" floating preview 
let g:ale_floating_preview = 1
" go syntax coloring - per vim-go via vim polyglot
let g:go_highlight_methods = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1

" svelte highlighting - via vim-polyglot
let g:ale_linters = {'svelte': ['svelte-language-server']}
let g:vim_svelte_plugin_use_typescript = 1

" add fzf
packadd! fzf
packadd! fzf.vim

" Turn syntax highlighting on.
syntax on
" necessary to keep syntax highlighting working properly
" With it, get an error: 'redrawtime' exceeded, syntax highlighting disabled
set re=0


" white space warning
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/

" Alehover on cntrl + .
nnoremap <C-k> :ALEHover<CR>
