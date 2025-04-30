zstyle ':completion:*' use-cache true
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/zcompcache
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:default' menu select=2

# Completers to use
zstyle ':completion:*::::' completer _expand _complete _match _prefix _ignored \
        _correct

# Match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Expand completer
zstyle ':completion:*:expand:*' tag-order 'all-expansions expansions'
zstyle ':completion:*:expand:*' group-order all-expansions expansions

# Ignore patterns
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o'
zstyle ':completion:*:functions' ignored-patterns '_*'

# Formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-dirs-first true

# Array access completion
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# Misc completions
zstyle ':completion:*:cd:*' tag-order local-directories path-directories
zstyle ':completion:*:manuals' separate-sections true
