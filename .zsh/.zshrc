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
[[ -f $ZDOTDIR/.zshrc_local ]] && . $ZDOTDIR/.zshrc_local

# Prompt settings

autoload -Uz colors && colors

local return_code="%(?..%{$fg[red]%}%?%{$reset_color%})"
local user_host="%{${terminfo[bold]}${fg[green]}%}%n@%m%{${reset_color}%}"
local current_dir="%{${terminfo[bold]}${fg[blue]}%} %~%{${reset_color}%}"
local exit_code="%(?,,%{$fg[red]%}↪ %?%{$reset_color%})"

# branch info
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f%k"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }

PROMPT='\
╭─${user_host} \
${current_dir} \
${vcs_info_msg_0_} \
$exit_code
%B$%b '

# exec tmux if initial starting
if [ $SHLVL = 1 ] && has "tmux" ; then
    # attach not attached tmux
    not_attached_tmux=$(tmux ls | awk '$11!="(attached)"{print $1}' | sed "s/://g" | head -1)
    if [ $not_attached_tmux != "" ]; then
        tmux a -t $not_attached_tmux
    else
        tmux
    fi
fi

