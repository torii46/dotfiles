#!/bin/bash
set -eu

command_list='
zsh
tac
vim
wget
curl
git
tmux
gdb
node
go
peco
colordiff
'

has() { type "${1:?too few arguments}" &>/dev/null; }

ostype(){ uname | tr "[:upper:]" "[:lower:]"; }

do_install()  {
    [ $# -ne 1 ] && echo "arguments must be only one" && exit 1;
    case "$(ostype)" in
        *'linux'*)   sudo apt-get install $1    ;;
        *'darwin'*)  brew install $1            ;;
        *) echo "Unkown Platform - Can't proceed installing command"; exit 1       ;;
    esac
}

# install homebrew if PLATFORM is Mac(darwin)
if [ "$(ostype)" == 'darwin' ] && !has 'homebrew' ; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# install command in command_list
for cmnd in ${command_list}; do
    do_install $cmnd
done
