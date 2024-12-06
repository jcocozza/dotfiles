" note:
" flake8 = linter
" mypy = linter/typechecker
" pylsp = lsp | https://github.com/python-lsp/python-lsp-server
" black = formatter
let b:ale_linters = ['flake8', 'mypy', 'pylsp']
let b:ale_fixers = ['black']
