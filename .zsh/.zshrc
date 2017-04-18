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

local toggl_info='$(toggl_current)'
toggl_current() {
    local tgc=$(toggl --cache --csv current)
    local tgc_time=$(echo $tgc | grep Duration | cut -d ',' -f 2)
    local tgc_dsc=$(echo $tgc | grep Description | cut -d ',' -f 2 | cut -c 1-20)
    local short_tgc_dsc=$(if [ $(echo $tgc_dsc | wc -m) -lt 20 ]; then echo $tgc_dsc; else echo "${tgc_dsc}.."; fi)
    if [ ! -n "$tgc_time" ] ; then
        echo "NoTimeEntry"
    else
        echo "[$tgc_time $short_tgc_dsc]"
    fi
}

local return_code="%(?..%{$fg[red]%}%?%{$reset_color%})"
local user_host="%{${terminfo[bold]}${fg[green]}%}%n@%m%{${reset_color}%}"
local current_dir="%{${terminfo[bold]}${fg[blue]}%} %~%{${reset_color}%}"
local exit_code="%(?,,%{$fg[red]%}↪ %?%{$reset_color%})"
PROMPT="\
╭─${user_host} \
${current_dir} \
$(toggl_current) \
$exit_code
%B$%b "

# exec tmux if initial starting
if [ $SHLVL = 1 ] && has "tmux" ; then
    tmux
fi
