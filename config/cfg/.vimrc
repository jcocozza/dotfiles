augroup LspSignatureHelp
augroup END

" general stuff
set nocompatible
filetype on
filetype plugin on
set number
set relativenumber
set cursorline
set nobackup

" pretty
syntax on
set background=dark
colorscheme retrobox
filetype indent on
set autoindent
set smartindent
set shiftwidth=4
set tabstop=4
set expandtab

let g:mapleader = " "

" make the searching better
set nohlsearch " don't keep search highligh on after search completed
set incsearch " highlight while searching
set ignorecase " don't match for case while searching

" navigation
nnoremap <C-f> :Ag<CR>
nnoremap ff :Files<CR>
let g:netrw_banner = 0
let g:netrw_liststyle = 3

" LSP - https://github.com/yegappan/lsp
let g:c_syntax_for_h = 1
nnoremap gd :LspGotoDefinition<CR>
nnoremap <Leader>h :LspHover<CR>
nnoremap <Leader>e :LspDiag nextWrap<CR>
nnoremap <Leader>w :LspDiag prevWrap<CR>

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
