#!/bin/bash
echo -n "Type global user.name (pass if blank): "
read name
echo -n "Type global user.email (pass if blank): "
read email
[ -z "$name"  ] && name=`git config user.name`
[ -z "$email" ] && email=`git config user.email` 

set -x

git config --global user.name "$name"
git config --global user.email "$email"
git config --global user.editor "vim -c"
git config --global color.diff auto
git config --global color.status auto
git config --global color.branch auto

git config --global core.editor = 'vim -c \"set fenc=utf-8\"'
git config --global core.precomposeunicode true
git config --global core.quotepath true

git config --global alias.co commit
git config --global alias.st 'status -sb'
git config --global alias.br branch
git config --global alias.ch checkout
git config --global alias.cl clone
git config --global alias.unadd 'reset HEAD'

git config --global alias.uncommit '!git reset --soft HEAD^'
git config --global alias.graph 'log --oneline --graph --decorate'
git config --global alias.current '!git symbolic-ref --short HEAD'
git config --global alias.alias '!git config --list | grep ^alias\\.'
