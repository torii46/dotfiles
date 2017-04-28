set nocompatible
filetype off

"""""""""""""""""""""""""""""""
" insertion-mode, status-bar settings
"""""""""""""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
else
    highlight clear StatusLine
    silent exec s:slhlcmd
endif
endfunction

function! s:GetHighlight(hi)
redir => hl
exec 'highlight '.a:hi
redir END
let hl = substitute(hl, '[\r\n]', '', 'g')
let hl = substitute(hl, 'xxx', '', '')
return hl
endfunction
""""""""""""""""""""""""""""""

filetype plugin indent on     " required!
filetype indent on

syntax on
colorscheme desert
set t_Co=256
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,euc-jp,sjis,cp934,iso-2022-jp
set scrolloff=5
set backspace=indent,eol,start
set vb t_vb=
set nostartofline
set showmatch
set matchtime=3
set wrap
set shiftround
set ignorecase
set smartcase
set mouse=a
if !has('nvim')
    set ttymouse=xterm2
endif
set showcmd
set number
set history=2000
set helplang=en
set laststatus=2
set ruler
set expandtab
set tabstop=4
set autoindent
set pumheight=10
set hlsearch
set shiftwidth=4
set tags=~/.tags
set wildmenu
set incsearch
set background=dark
set whichwrap=b,s,h,l,<,>,[,]
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲
set nolist
if has('persistent_undo')
    set undodir=$HOME/.vim/undo
    set undofile
end

highlight LineNr ctermfg=darkgray

inoremap jj <Esc>
nnoremap <C-]> g<C-]>
nnoremap Y y$
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>
nmap <CR> i<CR><ESC>
augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
augroup END

source ~/.vim/abbreviate.vim
