" note:
" flake8 = linter
" mypy = linter/typechecker
" jedi_panguage_server = lsp
" black = formatter
let b:ale_linters = ['flake8', 'mypy', 'jedi_language_server']
let b:ale_fixers = ['black']
let g:ale_python_flake8_options = '--max-line-length=88' " make flake8 compatible with black
