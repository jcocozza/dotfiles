" go syntax coloring - per vim-go via vim polyglot
let g:go_highlight_methods = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1

let b:ale_linters = ['gopls', 'golangci-lint']
let b:ale_fixers = ['gofmt']

" this allows us to add err != nil in normal mode super easily
let b:user_home=expand('~')
nnoremap ,err :execute ':-1read ' . b:user_home . '/.vim/templates/err.go'<CR>jww


