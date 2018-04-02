# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# enable completion caches
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
