# user specific functions
##############################

# Outputs current branch info in prompt format
function git_prompt_info() {
  local ref
  if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" != "1" ]]; then
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}

# Checks if working tree is dirty
function parse_git_dirty() {
  local STATUS=''
  local FLAGS
  FLAGS=('--porcelain')
  if [[ "$(command git config --get oh-my-zsh.hide-dirty)" != "1" ]]; then
    if [[ $POST_1_7_2_GIT -gt 0 ]]; then
      FLAGS+='--ignore-submodules=dirty'
    fi
    if [[ "$DISABLE_UNTRACKED_FILES_DIRTY" == "true" ]]; then
      FLAGS+='--untracked-files=no'
    fi
    STATUS=$(command git status ${FLAGS} 2> /dev/null | tail -n1)
  fi
  if [[ -n $STATUS ]]; then
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
  else
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

# ls when directory or less when file
l() {
    # if the argument is a single file or stdin is pipe
    if [[ ($# -eq 1 && -f "$1") || (-p /dev/stdin) ]]; then
        ${PAGER:-less -R} "$@"
    else
        ls -alF --color=auto "$@"
    fi
}


# proccess grep
p() {
    if [[ $# -gt 0 ]]; then
        ps auxww | grep "$@" else
        ps aux
    fi
}

# history grep
h() {
    if [[ $# -gt 0 ]]; then
        history | tac | sort -k2 -u | sort | grep "$@"
    else
        history 50
    fi
}

weather() {
    curl -4 "wttr.in/$1";
}

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

# simple calc by bc
calc() {
    bc -l <<< "$@"
}

# txt converter
txt2jpg() {
    txt=""
    while read buffer; do
        txt="$txt""$buffer""\n"
    done
    txt="$(echo -e $txt)"
    echo "$txt"
    convert -font /usr/share/fonts/truetype/ricty/Ricty-Regular.ttf label:"$(echo -e $txt)" $1
}

# user alias
##############################
alias ls='ls --color=tty'
alias ll='ls -aFl'
alias la='ls -A' alias lsd='ls -F | grep /'
alias emacs='emacs -nw'
alias em='emacs'
alias v='vim'
alias vi='vim'
alias vr='vim -R'
alias g++='g++ -std=c++11'
alias pip='sudo -H pip'
alias py='python'
alias sc='screen'
alias jman='LANG=ja_JP.utf8 man'
alias handai='ssh -i ~/.ssh/handai/id_rsa pstcp305@ssh-gw.eng.osaka-u.ac.jp'

# environment variables
export LANG=en_US.utf8
export LANGUAGE=en_US.utf8
export GOPATH=$HOME/.go

# path and export
export PATH="/usr/java/jre1.8.0_66/bin:/home/bin/":$PATH:"/home/torii/Scripts/":"/home/torii/.go/bin/"
export PATH="/usr/local/p/versions/python:$PATH"
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source /usr/local/bin/virtualenvwrapper.sh
#export GOROOT="/usr/bin/"
#export GOPATH=$HOME/go
#export GOBIN=$GOPATH/bin
#export PATH=$PATH:$GOPATH/bin

# ZSH Theme - Preview: http://gyazo.com/8becc8a7ed5ab54a0262a470555c3eed.png
autoload -Uz colors
colors
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#PROMPT="╭─%{$terminfo[bold]$fg[green]%}%n@%m%{$reset_color%} %{$termsinfo[bold]$fg[blue]%} %~%{$reset_color%} $(git_prompt_info)%{$reset_color%}
#%BS%b "

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

local user_host="%{$terminfo[bold]$fg[green]%}%n@%m%{$reset_color%}"
local current_dir="%{$terminfo[bold]$fg[blue]%} %~%{$reset_color%}"
#local rvm_ruby=""
#if which rvm-prompt &> /dev/null; then
#  rvm_ruby="%{$fg[red]%}‹$(rvm-prompt i v g)›%{$reset_color%}"
#else
#  if which rbenv &> /dev/null; then
#    rvm_ruby="%{$fg[red]%}‹$(rbenv version | sed -e "s/ (set.*$//")›%{$reset_color%}"
#  fi
#fi
#local git_branch="$(git_prompt_info)%{$reset_color%}"

#PROMPT="╭─${user_host} ${current_dir} ${rvm_ruby} ${git_branch}
#%B$%b "
PROMPT="╭─${user_host} ${current_dir}
%B$%b "
RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"

