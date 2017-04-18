#/bin/sh
for f in .??*; do
    [ "$f" = ".git" ] && continue
    [ "$f" = ".DS_Store" ] && continue
    [ "$f" = ".tmux.conf.osx" ] && continue
    [ "$f" = "*.swp" ] && continue
    ln -snfv $(pwd)"/$f" "$HOME"/"$f"
done

# make folder for vim undo record
mkdir -p "$HOME/.vim/undo" &>/dev/null

ln -s "$HOME/.vim" "$XDG_CONFIG_HOME/nvim"
