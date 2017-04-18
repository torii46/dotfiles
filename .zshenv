# Set .zshrc home directory
export ZDOTDIR="$HOME/.zsh"

# SET XDG Base Directory Specification HOME
export XDG_CONFIG_HOME="$HOME/.config"

# SET LANGUAGE
export LANGUAGE="en_US.UTF-8"
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"
export LC_CTYPE="${LANGUAGE}"
export LANGCHARSET="utf-8"

# Pager
export PAGER='less -s -M +Gg'
export LESSCHARST='utf-8'

# LESS man page colors
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[00;44;37m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
export LESS='-R'

# Add ~/bin to PATH
export PATH="$HOME/bin:$PATH"

# Append /usr/local/bin to PATH
export PATH="$PATH":/usr/local/bin

# Golang settings
[ -e /usr/local/go ] && export GOROOT=/usr/local/go
export GOPATH="$HOME/.go"
export GOBIN="$HOME/bin"
[ "$GOBIN" != "$HOME/bin" ] && export PATH="$GOBIN:$PATH"

# Python virtualenvs settings
#export WORKON_HOME=$HOME/.virtualenvs
#export PROJECT_HOME=$HOME/Devel

# History file and its size
export HISTFILE="$HOME"/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000
export LISTMAX=50
