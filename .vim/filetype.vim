augroup filetypedetect
    au BufRead,BufNewFile *.vim setfiletype vim 
    au BufRead,BufNewFile *.py  setfiletype python
    au BufRead,BufNewFile *.rb  setfiletype ruby
    au BufRead,BufNewFile *.php setfiletype php
    au BufRead,BufNewFile *.sh  setfiletype shell 
    au BufRead,BufNewFile *.c   setfiletype c
    au BufRead,BufNewFile *.cpp setfiletype cpp
    au BufRead,BufNewFile *.cc  setfiletype cpp
    au BufRead,BufNewFile *.go  setfiletype go 
    au BufRead,BufNewFile *.md  setfiletype markdown 
augroup END
