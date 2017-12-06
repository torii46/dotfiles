# For mac alias
if is_osx; then
    alias ls='ls -G'
else
    alias ls='ls --color=tty'
fi

# Common aliases
alias ..='cd ..'
alias ll='ls -aFl'      # Show files detail information
alias la='ls -AF'       # Show hidden all files
alias ld='ls -ld'       # Show directory info
alias l.='ls -d .*'     # Show only dotfiles
alias lx='ls -lXB'      # Sort by extention
alias lc='ls -ltcr'     # Sort by and show change time, most recent last
alias lu='ls -ltur'     # Sort by and show access time, most recent last
alias lt='ls -ltr'      # Sort by date, most recent last
alias lr='ls -lR'       # Recursive ls
alias lsd='ls -F | grep /' # Show directory name one line by one line

alias lesson='less -s -M +Gg'   # Less with line number and its percentage

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias t='tree -C'

alias jman='LANG=ja_JP.utf8 man'

alias h='history'
alias hi='history -i'
alias hd='history -d'

alias netcat='nc'
alias jupyterlab='jupyter lab'

alias crontab='crontab -i'

#alias docker-login='(){ docker exec -it $1 bash -lc "su - $3" }'
#alias docker-rm-exited="docker rm $(docker ps -aq --filter='status=exited')"

# Use if colordiff exists
if has 'colordiff'; then
    alias diff='colordiff -u'
else
    alias diff='diff -u'
fi

# alias open as mac-like open when linux
if is_linux -a has 'xdg-open'; then
    alias open='xdg-open'
fi

# Editor aliases
alias emacs='emacs -nw'
alias em='emacs'
alias v='vim'
alias vi='vim'
alias vr='vim -R'
alias g++='g++ -std=c++11'

#alias dic='sdcv'

# Global alias
alias -g L='| less'
alias -g G='| grep'

# Restart zsh
alias resource="source "$HOME"/.zshenv; source "$ZDOTDIR"/.zshrc"
alias relogin="export ZDOTDIR="$HOME"; exec $SHELL -l"

# exec command with low load
alias lowload='ionice -c 2 -n 7 nice -n 19'
# -c 2：ディスクI/Oの実行優先度をベストエフォートで実行
# -n 7：さらにこのコマンドの優先度を低くする
# -n 19：プロセスの実行優先度を一番低くする

# misc
alias my-ip="curl http://ifconfig.io"

###############################################################################
# alias like functions
###############################################################################

# tac (revese cat) like command
reverse() {
    if has "perl"; then
        perl -e 'print reverse <>'
    elif has "awk"; then
        awk '{a[i++]=$0} END {for (j=i-1; j>=0;) print a[j--] }'
    fi
}

# Proccess grep
p() {
    if [[ $# -gt 0 ]]; then
        ps auxww | grep "$@" else
        ps aux
    fi
}

# History grep
hgrep() {
    if [[ $# -gt 0 ]]; then
        history | reverse | sort -k2 -u | sort | grep "$@"
    else
        history 50
    fi
}

# Show weather cast
weather() {
    curl -4 "wttr.in/$1";
}

# Convert man to html
man2html_() {
    : ${1:?usage: man2html_ name|file}
    man -W ${1} >/dev/null || return
    sed '/^TROFF/s/-Tps/-Thtml/' /etc/man.conf | man -C /dev/fd/0 -t ${1}
}

# man include builtin commands
man () {
  case "$(type "$1")" in
    *builtin*) command -p man zshbuiltins | less -p "^       $1";; # built-in
    *[[?*]*) run-help "$1" | "${PAGER:-less}";;              # pattern
    *) command -p man "$@";;  # something else, presumed to be an external command
                              # or options for the man command or a section number
  esac
}

peco-history-selection() {
    BUFFER=`history -n 1 | reverse |  awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection

peco-src() {
    local selected_dir=$(ghq list -p | sed "s@$HOME/src/@@g" | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd $HOME/src/${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

# search
_keyword-and-nize() {
    local str;
    for i in $*; do
        # $strが空じゃない場合、検索ワードを+記号でつなぐ(and検索)
        str="$str${str:++}$i"
    done
    echo "$str"
}

google() {
    local opt
    if [ $# != 0 ]; then
        opt='search?num=100&gl=us&hl=en'
        opt="${opt}&q=$(_keyword-and-nize $*)"
    fi
    open -a Google\ Chrome http://www.google.com/$opt
}

sof() {
    local opt
    if [ $# != 0 ]; then
        opt='search?num=100&gl=us&hl=en'
        opt="${opt}&q=$(_keyword-and-nize $*)"
    fi
    open -a Google\ Chrome http://www.stackoverflow.com/$opt
}

qiita() {
    local opt
    if [ $# != 0 ]; then
        opt='search?num=100'
        opt="${opt}&q=$(_keyword-and-nize $*)"
    fi
    open -a Google\ Chrome http://qiita.com/$opt
}


# cd with auto ls
chpwd() {
    ls_abbrev
}

ls_abbrev() {
    # -C : Force multi-column output.
    # -F : Append indicator (one of */=>@|) to entries.
    local cmd_ls='ls'
    local -a opt_ls
    opt_ls=('-C' '--color=always')
    case "${OSTYPE}" in
        freebsd*|darwin*)
            if type gls > /dev/null 2>&1; then
                cmd_ls='gls'
            else
                # -G : Enable colorized output.
                opt_ls=('-CG')
            fi
            ;;
    esac

    local ls_result
    ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command $cmd_ls ${opt_ls[@]} | sed $'/^\e\[[0-9;]*m$/d')

    local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ')

    if [ $ls_lines -gt 4 ]; then
        echo "$ls_result" | head -n 2
        echo '...'
        echo "$ls_result" | tail -n 2
        echo "$(command ls -1 -A | wc -l | tr -d ' ') files exist"
    else
        echo "$ls_result"
    fi
}

# echo <args> | pbcopy
echopy() {
    echo "$@" | pbcopy
}
