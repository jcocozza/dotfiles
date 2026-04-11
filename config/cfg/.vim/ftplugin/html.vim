set equalprg=prettier
set formatprg=prettier

" this allows us to add <div class=""><div> in normal mode super easily
let b:user_home=expand('~')
nnoremap ,div :execute ':-1read ' . b:user_home . '/.vim/templates/div.html'<CR>12li
