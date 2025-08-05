" note:
" flake8 = linter
" mypy = linter/typechecker
" pyright = lsp
" black = formatter
let b:ale_linters = ['flake8', 'pyright']
let b:ale_fixers = ['black']
let g:ale_python_flake8_options = '--max-line-length=88' " make flake8 compatible with black
