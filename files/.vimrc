set nocompatible "disable compatibility w/ vi
filetype on " file type detection
filetype plugin on " load/enable plugins
filetype indent on " indent for file type
set number " line number
set relativenumber " relative line number
set cursorline " see the cursor
set nobackup " Do not save backup files.
set scrolloff=10 " do not let cursor scroll above/below 10 lines
set nowrap " no line wraps

" indenting better
set autoindent
set smartindent

" make tab work with spaces
set shiftwidth=4
set tabstop=4
set expandtab

" make the searching better
set nohlsearch " don't keep search highligh on after search completed
set incsearch " highlight while searching
set ignorecase " don't match for case while searching

" colors
set background=dark
colorscheme retrobox

" airline + ALE
let g:airline#extensions#ale#enabled = 1

" ALE auto completion enabled (see .vim/pack/git-plugins/start/ale)
let g:ale_completion_enabled = 1
" floating preview
let g:ale_floating_preview = 1
if v:version < 802
    let g:ale_floating_preview = 0
else
    let g:ale_floating_preview = 1
endif
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

" Turn syntax highlighting on.
syntax enable
" necessary to keep syntax highlighting working properly
" With it, get an error: 'redrawtime' exceeded, syntax highlighting disabled
set re=0

" white space warning
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/

" Alehover on cntrl + k
nnoremap <C-k> :ALEHover<CR>
