" rct.vim - easily copy text from remote vim to local clipboard

let g:rct_register = get(g:, 'rct_register', 'q')
let g:rct_command = get(g:, 'rct_command', 'rct')
let s:rct_last_yank = ''

function! s:CheckRCT()
    if !executable(g:rct_command)
        echoerr "rct not found. ensure it is installed and in your path"
        return 0
    endif
    return 1
endfunction

function! s:ProcessText()
    let yanked_text = getreg(g:rct_register)
    " Prevent duplicate processing
    if yanked_text ==# s:rct_last_yank
        return
    endif
    let s:rct_last_yank = yanked_text
    let cmd = g:rct_command . ' "' . escape(yanked_text, '"') . '"'
    let result = system(cmd)
    if v:shell_error != 0
        echoerr "rct command failed: " . result
        return
    endif
    echomsg result
endfunction

function! rct#Main()
    let l:exists = s:CheckRCT()
    if l:exists == 0
        return
    endif
    call s:ProcessText()
endfunction

autocmd TextYankPost * if v:event.regname == g:rct_register | call rct#Main() | endif
