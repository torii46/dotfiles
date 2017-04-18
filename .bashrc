# general settings
#############################################

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a colored prompt
PS1='╭─\[\e[1;32m\]\u@\h\[\e[1;34m\]$h \w\n\[\e[m\]$ '
#PS1='╭─\u@\h\$h \w\n\$ '

#
# user specefic utility functions
##############################################
has() {
    type "${1:?too few arguments}" &>/dev/null
}

# ostype returns the lowercase OS name
ostype(){
    uname | tr "[:upper:]" "[:lower:]"
}

# os_detect export the PLATFORM variable
os_detect() {
    case "$(ostype)" in
        *'linux'*)   PLATFORM='linux'   ;;
        *'darwin'*)  PLATFORM='osx'  ;;
        *'bsd'*)     PLATFORM='bsd'     ;;
        *)           PLATFORM='unknown' ;;
    esac
    export PLATFORM
}

# is_osx returns true if running OS is Mac
is_osx() {
    os_detect
    if [[ $PLATFORM == "osx" ]]; then
        return 0
    else
        return 1
    fi
}

# is_linux returns true if running OS is Linux
is_linux() {
    os_detect
    if [[ $PLATFORM == "linux" ]]; then
        return 0
    else
        return 1
    fi
}

# is_bsd returns true if running OS is BSD
is_bsd () {
    os_detect
    if [[ $PLATFORM == "bsd" ]]; then
        return 0
    else
        return 1
    fi
}

# echo_os echo OS name of running OS
echo_os() {
    local os
    for os in osx linux bsd; do
        if is_$os; then
            echo $os
        fi
    done
}

#
# user specefic useful functions
##############################################

# tac (reverse cat) like command
reverse() {
    if has "perl"; then
        perl -e 'print reverse<>'
    elif has "awk"; then
        awk '{a[i++]=$0} END {for (j = i - 1; j >= 0;) print a[j--] }'
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
    if [ $# -gt 0 ]]; then
        history | reverse | sort -k2 -u | sort | grep "$@"
    else
        history -50
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

#
# user specefic aliases
##############################################

# enable color support of ls and also add handy aliases
if is_osx; then
    alias ls='ls -FG'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
elif [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto -F'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Common aliases
alias ..='cd ..'
alias ll='ls -alF'
alias ll='ls -aFl'      # Show files detail information
alias la='ls -AF'       # Show hidden all files
alias ld='ls -ld'       # Show directory info
alias lx='ls -lXB'      # Sort by extention
alias lc='ls -ltcr'     # Sort by and show change time, most recent last
alias lu='ls -ltur'     # Sort by and show access time, most recent last
alias lt='ls -ltr'      # Sort by date, most recent last
alias lr='ls -lR'       # Recursive ls
alias lsd='ls -F | grep /' # Show directory name one line by one line

alias lesson='less -s -M +Gg'

alias h='history'
alias hd='history -d'
alias hi='history -i'

alias t='tree -C'

alias jman='LANG=ja_JP.utf8 man'

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
alias L='| less'
alias G='| grep'

# Restart bashrc
alias relogin="exec $SHELL -l"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
