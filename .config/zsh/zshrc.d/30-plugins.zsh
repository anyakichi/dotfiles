autoload -Uz add-zsh-hook colors compinit is-at-least zmv
compinit -d $XDG_CACHE_HOME/zsh/zcompdump
colors

## cdr
autoload -Uz cdr chpwd_recent_dirs

add-zsh-hook chpwd chpwd_recent_dirs

zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file $XDG_STATE_HOME/zsh/chpwd-recent-dirs
zstyle ':chpwd:*' recent-dirs-max 1000
zstyle ':chpwd:*' recent-dirs-prune "pattern:^${HOME}$"
zstyle ':completion:*' recent-dirs-insert always

## edit-command-line
autoload -Uz edit-command-line
zle -N edit-command-line

bindkey '^Xe' edit-command-line
bindkey '^X^E' edit-command-line

## factorize-last-two-args
autoload -Uz factorize-last-two-args
zle -N factorize-last-two-args
bindkey '^X^F' factorize-last-two-args

## modify-current-argument
autoload -Uz modify-current-argument

quote-current-word-in-single() { modify-current-argument '${(qq)${(Q)ARG}}' }
zle -N quote-current-word-in-single

quote-current-word-in-double() { modify-current-argument '${(qqq)${(Q)ARG}}' }
zle -N quote-current-word-in-double

bindkey "^X'" quote-current-word-in-single
bindkey '^X"' quote-current-word-in-double

## select-word-style
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /:@+|"
zstyle ':zle:*' word-style unspecified
