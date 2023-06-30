set nocp
set nu rnu
color default
syntax on
set ruler
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set showmatch
set hlsearch
set incsearch
set title
set confirm
set t_Co=256
set langmap=ÔÈÑÂÓÀÏĞØÎËÄÜÒÙÇÉÊÛÅÃÌÖ×Íß;ABCDEFGHIJKLMNOPQRSTUVWXYZ,ôèñâóàïğøîëäüòùçéêûåãìö÷íÿ;abcdefghijklmnopqrstuvwxyz
nnoremap <F5> :w<CR>:!echo '--------'; make debug<CR>
nnoremap <F6> :w<CR>:!echo '--------'; make run<CR>
nnoremap <F7> :w<CR>:!echo '--------'; make all<CR>
nnoremap <F8> :w<CR>:!echo '--------'; make clean<CR>
nnoremap <F9> :w<CR>:!echo '--------'; make rebuild<CR>
set runtimepath^=~/.vim/
set laststatus=2
set noshowmode
nnoremap <F3> :w<CR>:%ClangFormat<CR>:w<CR>
language en_US.utf8
set smartindent
let g:clang_use_library = 1
let g:clang_format#codestyle = "chromium"
let g:clang_format#style_options = { "ColumnLimit": 0 }
