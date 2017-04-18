autoload -U compinit promptinit && compinit

# Important
zstyle ':completion:*' menu select=2

# Completing
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' verbose yes
zstyle ':completion:*' use-cache true

zstyle ':completion:*' list-colors "{LS_COLORS}"
