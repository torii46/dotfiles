#/bin/sh
for f in .??*; do
    [ "$f" = ".git" ] && continue
    [ "$f" = ".DS_Store" ] && continue
    [ "$f" = ".tmux.conf.osx" ] && continue
    ln -snfv $(pwd)"/$f" "$HOME"/"$f"
done

ln -s "$HOME/.vim" "$XDG_CONFIG_HOME/nvim"
