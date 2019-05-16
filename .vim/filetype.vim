augroup filetypedetect
    au BufRead,BufNewFile *.vim   setfiletype vim 
    au BufRead,BufNewFile *.md    setfiletype markdown 
    au BufRead,BufNewFile *.html  setfiletype html
    au BufRead,BufNewFile *.css   setfiletype css
    au BufRead,BufNewFile *.js    setfiletype javascript 
    au BufRead,BufNewFile *.py    setfiletype python
    au BufRead,BufNewFile *.rb    setfiletype ruby
    au BufRead,BufNewFile *.php   setfiletype php
    au BufRead,BufNewFile *.pl    setfiletype perl
    au BufRead,BufNewFile *.sh    setfiletype sh 
    au BufRead,BufNewFile *.c     setfiletype c
    au BufRead,BufNewFile *.cpp   setfiletype cpp
    au BufRead,BufNewFile *.cc    setfiletype cpp
    au BufRead,BufNewFile *.go    setfiletype go 
    au BufRead,BufNewFile *.swift setfiletype swift
    au BufRead,BufNewFile *.rs    setfiletype rust
    au BufRead,BufNewFile *nginx*.conf    setfiletype nginx
    au BufRead,BufNewFile *.tf    setfiletype terraform
augroup END
