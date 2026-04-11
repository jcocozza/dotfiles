set equalprg=prettier
set formatprg=prettier

call LspAddServer([#{
	\    name: 'tsserver',
	\    filetype: ['javascript', 'typescript'],
	\    path: 'tsserver',
	\    args: ['--stdio'],
	\  }])
