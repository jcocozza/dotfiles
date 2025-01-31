" note:
" flake8 = linter
" mypy = linter/typechecker
" pylsp = lsp | https://github.com/python-lsp/python-lsp-server
" black = formatter
let b:ale_linters = ['flake8', 'mypy', 'pylsp']
let b:ale_fixers = ['black']
let g:ale_python_flake8_options = '--max-line-length=88' " make flake8 compatible with black
let g:ale_python_pylsp_options = '--disable-plugins=flake8' " pylsp doesn't need to also check flake8 as ALE does it for us
