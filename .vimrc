"" Alger's Dev Environment

"Vundle

set nocompatible
filetype off
"
set rtp+=~/.vim/vundle.git/
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'vividchalk.vim'
"Bundle 'vim-scripts/ShowMarks'
Bundle 'vim-scripts/LargeFile'
let g:LargeFile=10
"
" Language Plugins
"
Bundle 'vim-scripts/pig.vim'
Bundle 'vim-scripts/JavaScript-Indent.git'
Bundle 'scrooloose/syntastic'

" use visual bell instead of beeping
set vb

" incremental search
set incsearch
set smartcase

set backup
set backupdir=~/.vim/backup

" syntax highlighting
syntax enable
set cindent
set cinoptions=:0

" autoindent
set autoindent|set smartindent

" 4 space tabs
set tabstop=2|set shiftwidth=2|set expandtab

" show matching brackets
set showmatch

" show line numbers
set number

" JSON
"autocmd BufNewFile,BufRead *.json set ft=javascript

" Color Schema
let g:zenburn_high_Contrast=1
colorscheme vividchalk
set t_Co=256

"
" http://vim.wikia.com/wiki/Remove_unwanted_spaces#Automatically_removing_all_trailing_whitespace
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
autocmd BufWritePre *.md,*.html,*.css,*.js,*.rb,*.py,*.php,*.pl,*.bash,*.sh,*.c,*.cpp,*.java :%s/\s\+$//e
" Show trailing whitespace except when typing at the end of a line
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

" ref: <thorstenlorenz.wordpress.com/2011/07/11/how-to-make-node-js-coffeescript-and-jasmine-play-nice-with-vim/>
autocmd BufWritePost *.coffee silent CoffeeMake! -b | cwindow
autocmd FileType javascript set makeprg=node\ %\ $*
autocmd FileType java compiler javac
autocmd FileType java set makeprg=javac\ %&&echo\ %\\\|sed\ 's/.java//'\\\|xargs\ java
autocmd FileType sh set makeprg=(chmod\ +x\ %\ &&\ ./%\ $*)
autocmd FileType perl set makeprg=perl\ %
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd BufRead,BufNewFile *.pig set filetype=pig syntax=pig
autocmd BufRead,BufNewFile *.ru set filetype=ruby
autocmd BufRead,BufNewFile *.pp set filetype=ruby
autocmd BufRead,BufNewFile *.json set filetype=javascript
autocmd BufRead,BufNewFile *.arc set filetype=lisp
function! s:DetectNode()
  if getline(1) == '#!/usr/bin/env node'
    set ft=javascript
  endif
endfun
autocmd BufNewFile,BufRead * call s:DetectNode()
