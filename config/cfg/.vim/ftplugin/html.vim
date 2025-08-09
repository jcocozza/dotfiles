let b:ale_fixers = ['prettier']
" this allows us to add err != nil in normal mode super easily
let b:user_home=expand('~')
nnoremap ,div :execute ':-1read ' . b:user_home . '/.vim/templates/div.html'<CR>12li
