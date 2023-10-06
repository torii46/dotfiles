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

# Append left /usr/local/bin to PATH
export PATH=/usr/local/bin:"$PATH"

export PATH="$PATH:$HOME/.local/bin"

# Golang settings
[ -e /usr/local/go ] && export GOROOT=/usr/local/go
export GOPATH="$HOME/.go"
export GOBIN="$HOME/bin"
[ "$GOBIN" != "$HOME/bin" ] && export PATH="$GOBIN:$PATH"

# Java settings
[[ $(uname) == 'Darwin' ]] && export JAVA_HOME=`/usr/libexec/java_home`
export JAVA_OPTS=-Dfile.encoding=UTF-8
export M2_HOME="/usr/local/lib/apache-maven-3.5.0/bin/"
export PATH="$PATH:$M2_HOME"
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh" # GRADLE_HOME is set by this command

# Python virtualenvs settings
#export WORKON_HOME=$HOME/.virtualenvs
#export PROJECT_HOME=$HOME/Devel

# History file and its size
export HISTFILE="$HOME"/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000
export LISTMAX=50

## Set path for pyenv
export PATH="$HOME/.pyenv/shims/:$PATH"
export PYENV_ROOT="${HOME}/.pyenv"
if [ -d "${PYENV_ROOT}" ]; then
    export PATH="${PYENV_ROOT}/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

## gloud settings
if [ -d "$HOME/google-cloud-sdk" ]; then export PATH="$PATH:$HOME/google-cloud-sdk/bin"; fi
