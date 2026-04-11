set equalprg=gofmt
set formatprg=gofmt

call LspAddServer([#{
	\    name: 'golang',
	\    filetype: ['go', 'gomod'],
	\    path: 'gopls',
	\    args: ['serve'],
	\    syncInit: v:true
	\  }])

" this allows us to add err != nil in normal mode super easily
let b:user_home=expand('~')
nnoremap ,err :execute ':-1read ' . b:user_home . '/.vim/templates/err.go'<CR>jww
