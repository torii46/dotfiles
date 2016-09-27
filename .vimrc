set nocompatible
filetype off
"""""""""""""""""""""""""""""""""""""""""""
"""""""""" Plugin settings """"""""""""""""
"""""""""""""""""""""""""""""""""""""""""""

if has('vim_starting')
    set nocompatible
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

    NeoBundleFetch 'Shougo/neobundle.vim'
    NeoBundle 'itchyny/lightline.vim'
    NeoBundle 'Shougo/unite.vim'
    NeoBundle 'Shougo/vimfiler'
    NeoBundle 'Shougo/vimproc'
    "NeoBundle 'Shougo/vimshell'
    NeoBundle 'Shougo/unite.vim'
    "NeoBundle 'Shougo/neomru.vim'
    NeoBundle 'Shougo/unite-outline'
    NeoBundle 'Shougo/neocomplete.vim'
    NeoBundle 'Shougo/neosnippet'
    NeoBundle 'Shougo/neosnippet-snippets'
    let s:my_snippet = '~/.vim/snippets/'
    let g:neosnippet#snippets_directory = s:my_snippet
    imap <C-k> <Plug>(neosnippet_expand_or_jump)
    smap <C-k> <Plug>(neosnippet_expand_or_jump)

    NeoBundle 'thinca/vim-quickrun'

    NeoBundle 'kana/vim-smartinput'
    NeoBundle 'kana/vim-operator-user'
    NeoBundle 'kana/vim-textobj-user'
    NeoBundle 'kana/vim-textobj-indent'
    NeoBundle 'rhysd/vim-operator-surround'

    NeoBundle 'mattn/emmet-vim'
    NeoBundle 'vim-scripts/Align'
    NeoBundle 'vim-scripts/YankRing.vim'
    let g:yankring_history_dir = '~/.vim/bundle/'

    " go plugin
    NeoBundle 'fatih/vim-go'

    " ctags plugin for vim
    NeoBundle 'szw/vim-tags'

    " file tree
    NeoBundle 'scrooloose/nerdtree'

    " easy cotroll for comment On/Off
    NeoBundle 'tomtom/tcomment_vim'

    " indent highlight
    NeoBundle 'nathanaelkane/vim-indent-guides'

    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_guide_size = 1
    let g:indent_guides_start_level = 2

    " highlight unnecessary whitespace of the end of line
"    NeoBundle 'bronson/vim-trailing-whitespace'

    " highlight log file (highlight ansi coloring file)
    NeoBundle 'vim-scripts/AnsiEsc.vim'

    " python 1.syntax chcker 2.pep8 syntax 3.tools for virtualenv 4.txtobj
    NeoBundle 'kevinw/pyflakes-vim'
    NeoBundle 'hynek/vim-python-pep8-indent'
    NeoBundle 'jmcantrell/vim-virtualenv'
    NeoBundle 'bps/vim-textobj-python'

call neobundle#end()

NeoBundleCheck



" neocomplete用設定

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'


"""""""""""""""""""""""""""""""""""""""""""
"""""" User specific bundle """""""""""""""
"""""""""""""""""""""""""""""""""""""""""""

" 挿入モード時、ステータスラインの色を変更
" """"""""""""""""""""""""""""""
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
set ttymouse=xterm2
set showcmd
set number
set history=2000
set helplang=en
set laststatus=2
set ruler
set expandtab
set tabstop=4
set autoindent
set hlsearch
set shiftwidth=4
set tags=~/.tags
set wildmenu
set incsearch
set background=dark
set whichwrap=b,s,h,l,<,>,[,]
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲

highlight LineNr ctermfg=darkgray

inoremap jj <Esc>
nnoremap <C-]> g<C-]>
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

ab -*- -*- coding: utf-8 -*-
ab mapir map(int, raw_input().split())
"ab #inc #include
"ab #def #define
