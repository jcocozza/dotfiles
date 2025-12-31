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

let g:mapleader = " "

" make the searching better
set nohlsearch " don't keep search highligh on after search completed
set incsearch " highlight while searching
set ignorecase " don't match for case while searching
" open Ag for fuzzy searching
nnoremap <C-f> :Ag<CR>
" use fzf to find files
nnoremap ff :Files<CR>

" file browsing
let g:netrw_banner=0
let g:netrw_liststyle=3 " tree view

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
    set background=dark
else
    " we want to default to the default colorschemes
    colorscheme retrobox
    set background=dark
endif

" airline
let g:airline#extensions#ale#enabled = 1

" ALE
let g:ale_linters_explicit = 1 " only use linters explicitly set (in ftplugin)
let g:ale_completion_enabled = 1 " auto completion enabled (see .vim/pack/git-plugins/start/ale)
if v:version < 802 " vim only has floating on greater then 8.02
    let g:ale_floating_preview = 0
    let g:ale_set_preview = 1
    let g:ale_echo_cursor = 1
else
    let g:ale_floating_preview = 1
    let g:ale_set_preview = 1
    let g:ale_echo_cursor = 1
endif

let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace']
\ }

" Alehover on cntrl + k
nnoremap <C-k> :ALEHover<CR>
" go to next err
nnoremap  <Leader>e :ALENext<CR>
" go to previous err
nnoremap <Leader>w :ALEPrevious<CR>

" this is somewhat elaborate
" see https://github.com/dense-analysis/ale/issues/1645 for the original
" inspiration. I found the suggested solution didn't quite work.
function ALELSPMappings()
    let linters=ale#linter#Get(&filetype)
    if (len(linters) == 0) " when zero we do nothing
        return
    endif

  " check through all linters
  " if an lsp exists, check if there is an executable for it
  " if so, then we can do the remap
    let linter_exists=0
    for linter in linters
        if !empty(linter.lsp)
            let exe=call(linter.executable, [bufnr('')])

            if executable(exe)
                let linter_exists=1
            endif
        endif
    endfor

    if (linter_exists == 1)
        nnoremap <buffer> <C-]> :ALEGoToDefinition<CR>
    endif
endfunction
autocmd BufRead,FileType * call ALELSPMappings()

" Turn syntax highlighting on.
syntax enable
" necessary to keep syntax highlighting working properly
" With it, get an error: 'redrawtime' exceeded, syntax highlighting disabled
set re=0

" white space warning
highlight ExtraWhitespace ctermbg=red guibg=red
" autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

set tags=./tags,tags;/    " Look for tags file in the current directory and parent directories

function! TODO()
  execute 'vimgrep /TODO:/ **/*'
  copen
endfunction

command! -nargs=0 TODO call TODO()

" this is absolute S-teir programming: I shamelessly steal this from https://www.youtube.com/watch?v=E-ZbrtoSuzw
" essentially it will take the last yanked buffer(ON REMOTE) and kick it to the local clipboard
function! OSC52Yank()
  let buffer=system('base64 -w0', @0)
  if exists("$TMUX")
    " this more elaborate escape sequence is for older versions of tmux.
    " technically, on newer versions the else clause will work just fine
    " provided the following are set in the .tmux.conf:
    " set -g set-clipboard on
    " set -g allow-passthrough on
    " But from what i can tell, the newer versions of tmux work with the old
    " escape sequence (provided the above configs are set)
    let buffer=printf("\x1bPtmux;\x1b\x1b]52;c;%s\x07\x1b\\", buffer)
  else
    let buffer=printf("\x1b]52;c;%s\x07", buffer)
  endif
  call writefile([buffer], '/dev/fd/2', 'b') " we can use stderr(/dev/fd/2) to send the content back this means this probably won't work on a remote no-unix machine
endfunction
" TODO: this is kinda a dumb way to do it, in the future figure out a smoother
" way to integrate the correctly
nnoremap <Leader>y :call OSC52Yank()<CR>

" this is a kinda hacky way of getting the dotfiles repo
" it assumes that the bashrc is symlinked from the repo
let dotfiles = system('cd $(dirname "$(readlink ~/.bashrc)")/../.. && pwd')
let dotfiles = substitute(dotfiles, '\n\+$', '', '')
execute 'source' fnameescape(dotfiles . '/config/lcfg/.lvimrc')
