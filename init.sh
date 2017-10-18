#!/bin/bash

for f in .??*; do
    [ "$f" = ".git" ] && continue
    [ "$f" = ".DS_Store" ] && continue
    [ "$f" = ".tmux.conf.osx" ] && continue
    [ "$f" = "*.swp" ] && continue
    [ "$f" = ".gitignore" ] && continue
    [ "$f" = ".gradle" ] && continue
    ln -snfv "`pwd`/$f" "$HOME/$f"
done

# make ~/bin and link scripts to it
mkdir "$HOME/bin" 2> /dev/null
for f in $(ls ./bin); do
  [ ${f##*.} != 'sh' ] && ln -snfv "`pwd`/bin/$f" ~/bin/"$f"
done

# make ~/src/template and link template to it
mkdir -p "$HOME/src/template" 2>/dev/null
for f in $(ls ./bin); do
 ln -snfv "`pwd`/template/$f" "$HOME/src/template/$f"
done

# make folder for vim undo record
mkdir -p "$HOME/.vim/undo" &>/dev/null

ln -s "$HOME/.vim" "$XDG_CONFIG_HOME/nvim" 2> /dev/null
