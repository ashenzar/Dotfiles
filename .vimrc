filetype plugin indent on
set tabstop=4
set shiftwidth=4

set nu
syntax on
colorscheme peachpuff

inoremap " ""<Left>
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>

inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"

inoremap <expr> <Cr> strpart(getline('.'), col('.')-2, 1) == "{" ? "<Cr><Esc>O" : "<Cr>"
inoremap <expr> <Space> strpart(getline('.'), col('.')-2, 1) == "(" ? "  <Left>" : " "

nnoremap ; A;<Esc>

command C !time javac %
command R !java -cp %:p:h %:t:r
command P !python %
command M !time make %:t:r
command J !./%:t:r

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif
