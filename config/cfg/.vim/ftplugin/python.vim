set equalprg=ruff\ format\ --stdin-filename\ %\ -
set formatprg=ruff\ format\ --stdin-filename\ %\ -

call LspAddServer(
    \ [
    \ #{
	\    name: 'ty',
	\    filetype: ['python'],
	\    path: 'ty',
	\    args: ['server'],
	\    definitionFallback: v:true,
	\ },
    \ #{
	\    name: 'ruff',
	\    filetype: ['python'],
	\    path: 'ruff',
	\    args: ['server'],
	\ },
\ ])
