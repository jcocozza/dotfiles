set equalprg=clang-format
set formatprg=clang-format
call LspAddServer([#{
	\    name: 'clangd',
	\    filetype: ['c'],
	\    path: 'clangd',
	\    args: ['--background-index']
	\  }])
