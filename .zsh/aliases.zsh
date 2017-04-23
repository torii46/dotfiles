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

# todoist and toggle aliases
alias todo='todoist'
alias tl='todoist --project-namespace --namespace --color list'
alias ta='todoist add'
alias tge='toggl stop'

###############################################################################
# alias like functions
###############################################################################

# tac (revese cat) like command
reverse() {
    if has "perl"; then
        perl -e 'print reverse <>'
    elif has ""; then
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


# Simple calc by bc
calc() {
    bc -l <<< "$@"
}

# Convert man to html
man2html_() {
    : ${1:?usage: man2html_ name|file}
    man -W ${1} >/dev/null || return
    sed '/^TROFF/s/-Tps/-Thtml/' /etc/man.conf | man -C /dev/fd/0 -t ${1}
}

# Shell script rich template generator
new-script() {
    cat <<'SHELLSCRIPT' > "$1"
#!/bin/sh
usage() {
    cat <<HELP
NAME:
   $0 -- {one sentence description}

SYNOPSIS:
  $0 [-h|--help]
  $0 [--verbose]

DESCRIPTION:
   {description here}

  -h  --help      Print this help.
      --verbose   Enables verbose mode.

EXAMPLE:
  {examples if any}

HELP
}

main() {
    SCRIPT_DIR="$(cd $(dirname "$0"); pwd)"

    for ARG; do
        case "$ARG" in
            --help) usage; exit 0;;
            --verbose) set -x;;
            --) break;;
            -*) 
                OPTIND=1
                while getopts h OPT "$ARG"; do
                    case "$OPT" in
                        -h) usage; exit 0;;
                    esac
                done
                ;;
        esac
    done

    # do something
}

main "$@"

SHELLSCRIPT
    chmod +x "$1"
}


toggl-start-todoist () {
    local selected_item_id=`todoist --project-namespace --namespace list | peco | cut -d ' ' -f 1`
    if [ ! -n "$selected_item_id" ]; then
        return 0
    fi
    local selected_item_content=`todoist --csv show ${selected_item_id} | grep Content | cut -d',' -f2- | sed s/\"//g`
    if [ -n "$selected_item_content" ]; then
        BUFFER="toggl start \"${selected_item_content}\""
        CURSOR=$#BUFFER
        zle accept-line
    fi
}
zle -N toggl-start-todoist
bindkey '^xts' toggl-start-todoist

todoist-select-itemid() {
    local selected_item_id=`todoist --project-namespace --namespace list | peco | cut -d ' ' -f 1`
    if [ ! -n "$selected_item_id" ]; then
        return 0
    fi
    BUFFER=${BUFFER}${selected_item_id}
    CURSOR=$#BUFFER
}
zle -N todoist-select-itemid
bindkey '^xti' todoist-select-itemid

peco-history-selection() {
    BUFFER=`history -n 1 | tail | reverse |  awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection
