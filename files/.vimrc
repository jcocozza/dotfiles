" general stuff
set nocompatible "disable compatibility w/ vi
filetype on " file type detection
filetype plugin on " load/enable plugins
set number " line number
set relativenumber " relative line number
set cursorline " see the cursor
set nobackup " Do not save backup files.
set scrolloff=10 " do not let cursor scroll above/below 10 lines
set nowrap " no line wraps

" indenting better
filetype indent on " indent for file type
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
"" open Ag for fuzzy searching
nnoremap <C-f> :Ag<CR>

" file browsing
let g:netrw_banner=0
let g:netrw_liststyle=3 " tree view

" colors
set background=dark

function! ColorSchemeExists(scheme)
  " Try to load the color scheme silently and check for errors
  silent! execute 'colorscheme ' . a:scheme
  " If there was no error, the color scheme exists
  if v:errmsg == ''
    return 1
  endif
  " Reset any error messages
  let v:errmsg = ''
  return 0
endfunction

if !ColorSchemeExists('retrobox')
    " gruvbox is the backup stored in .vim/colors
    colorscheme gruvbox
else
    " we want to default to the default colorschemes
    colorscheme retrobox
endif

" airline
let g:airline#extensions#ale#enabled = 1

" ALE
let g:ale_linters_explicit = 1 " only use linters explicitly set (in ftplugin)
let g:ale_completion_enabled = 1 " auto completion enabled (see .vim/pack/git-plugins/start/ale)
if v:version < 802 " floating preview
    let g:ale_floating_preview = 0
else
    let g:ale_floating_preview = 1
endif

let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace']
\ }

" Alehover on cntrl + k
nnoremap <C-k> :ALEHover<CR>
" go to next err
nnoremap  <C-w>e :ALENext<CR>
" go to previous err
nnoremap <C-w>w :ALEPrevious<CR>

" Turn syntax highlighting on.
syntax enable
" necessary to keep syntax highlighting working properly
" With it, get an error: 'redrawtime' exceeded, syntax highlighting disabled
set re=0

" white space warning
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/

let g:toofar_ignore_filetypes = ['markdown', 'html']

set tags=./tags,tags;/    " Look for tags file in the current directory and parent directories

function! TODO()
  execute 'vimgrep /TODO:/ **/*'
  copen
endfunction

command! -nargs=0 TODO call TODO()

source ~/dotfiles/files/local_vimrc.vim
