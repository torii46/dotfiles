umask 022

# Return if zsh is called from vim
if [[ -n $VIMRUNTIME ]]; then
    return 0
fi

loadlib() {
    lib="${1:?too few arguments}"
    if [ -f "$lib" ]; then
        . "$lib"
    fi
}

# Load zsh settings files
loadlib "$ZDOTDIR"/utils.zsh
loadlib "$ZDOTDIR"/aliases.zsh
loadlib "$ZDOTDIR"/setopt.zsh
loadlib "$ZDOTDIR"/misc.zsh

# Load OS dependencies of zsh settings if exists
[[ -f $ZDOTDIR/.zshrc_$(ostype) ]] && . $ZDOTDIR/.zshrc_$(ostype)

# Load Local dependencies of zsh settings if exists
[[ -f $ZDOTDIR/.zshrc_$(ostype) ]] && . $ZDOTDIR/.zshrc_$(ostype)

# Prompt settings
autoload -Uz colors && colors

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
local user_host="%{$terminfo[bold]$fg[green]%}%n@%m%{$reset_color%}"
local current_dir="%{$terminfo[bold]$fg[blue]%} %~%{$reset_color%}"
PROMPT="╭─${user_host} ${current_dir}
%B$%b "
RPS1="${return_code}"
