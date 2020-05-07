autoload -Uz add-zsh-hook cdr chpwd_recent_dirs

zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-max 1000
zstyle ':chpwd:*' recent-dirs-prune "pattern:^${HOME}$"
zstyle ':completion:*' recent-dirs-insert always

add-zsh-hook chpwd chpwd_recent_dirs

__fzf-cdr()
{
    cdr -l | sed 's/^[[:digit:]]*[[:space:]]*//'
}

