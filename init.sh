#/bin/sh
for f in .??*; do
    [ "$f" = ".git" ] && continue
    [ "$f" = ".DS_Store" ] && continue
    ln -snfv $(pwd)"/$f" "$HOME"/"$f"
done
