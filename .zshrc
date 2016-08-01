#
# .zshrc:
#       Zsh configuration
#

#
# Include common settings
#
if [ -f ${HOME}/.shrc ]; then
    . ${HOME}/.shrc
fi


#
# Parameters
#
PROMPT='%m%# '
RPROMPT='$(my_rprompt)'

DIRSTACKSIZE=20

HISTFILE=~/.zsh_history
HISTSIZE=20000
SAVEHIST=100000

MAILCHECK=0

cdpath=(~ ~/src ~/Documents)
fpath=(~/.zsh/functions $fpath)

typeset -U cdpath fpath hosts mailpath manpath path


#
# Aliases
#
ls --color=auto >/dev/null 2>&1 && alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lsd='ls -ld *(-/DN)'
alias lsa='ls -ld .*'

alias cp='nocorrect cp'
alias make='nocorrect make'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias rm='nocorrect rm'

alias man='LANG=C man'

alias grep='egrep'
which vim > /dev/null 2>&1 && alias vi=vim
alias vimdiff='vim +next "+execute \"DirDiff\" argv(0) argv(1)"'
alias mz='mutt -Z'
alias ag='ag --pager "less -FRX"'
which open >/dev/null 2>&1 || alias open=xdg-open

if [[ -n "${STY}" ]] then
    alias ssh=ssh-screen
elif [[ -n "${TMUX}" ]] then
    alias ssh=ssh-tmux
fi

# Global aliases
alias -g G='|grep'
alias -g L='|less'
alias -g LL='2>&1|less'
alias -g M='|more'
alias -g H='|head'
alias -g I='|iconv'
alias -g S='|sort'
alias -g T='|tail'
alias -g W='|wc'
alias -g X='|xargs'
alias -g X0='|xargs -0'
alias -g N='>/dev/null'
alias -g NN='>/dev/null 2>&1'

# OS specific aliases
case $OSTYPE in
    darwin*)
        alias ka='open -a "Keychain Access"'
        alias ldd='otool -L'
        ;;
    netbsd*)
        ;;
    solaris*)
        ;;
esac


#
# Options
#

# Changing Directories
setopt auto_cd auto_pushd cdable_vars
setopt pushd_ignore_dups pushd_minus pushd_silent pushd_to_home

# Completion
setopt complete_in_word

# Expansion and Grobbing
setopt extended_glob numeric_glob_sort

# History
setopt extended_history
setopt hist_ignore_alldups hist_ignore_dups hist_ignore_space hist_reduce_blanks
setopt inc_append_history

# Input/Output
setopt correct list_packed

# Prompt
setopt prompt_subst
setopt transient_rprompt

# Zle
setopt no_beep


#
# Modules
#
zmodload -i zsh/complist
zmodload -a zsh/stat stat
zmodload -a zsh/zprof zprof


#
# Key bindings
#
bindkey -e
bindkey ' ' magic-space
bindkey '^D' list-choices
bindkey '^I' complete-word
bindkey -M menuselect \
        '^P' up-line-or-history '^N' down-line-or-history \
        '^B' backward-char '^F' forward-char
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward
bindkey '^]' insert-last-word
bindkey '^[u' undo
bindkey '^[r' redo


#
# Plugins
#
autoload -Uz add-zsh-hook colors compinit is-at-least zmv
compinit
colors

## cdr
autoload -Uz cdr chpwd_recent_dirs

zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-max 1000
zstyle ':chpwd:*' recent-dirs-prune "pattern:^${HOME}$"
zstyle ':completion:*' recent-dirs-insert always

add-zsh-hook chpwd chpwd_recent_dirs

## antigen
if [[ -f $HOME/.zsh/antigen/antigen.zsh ]]; then
    ADOTDIR=$HOME/.zsh/antigen
    source $ADOTDIR/antigen.zsh

    antigen apply
fi

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

## vcs_info
autoload -Uz vcs_info

zstyle ':vcs_info:*' max-exports 4
zstyle ':vcs_info:*' formats '%s' '%b' '%R'
zstyle ':vcs_info:*' actionformats '%s' '%b|%a' '%R'

add-zsh-hook precmd vcs_info


#
# Functions
#

my_rprompt()
{
    if [[ "$vcs_info_msg_2_" = "$HOME" || -z "$vcs_info_msg_2_" ]]; then
        echo -n "%$(($COLUMNS - 15))<...<%~"
    else
        echo -n "%F{green}$vcs_info_msg_0_:$vcs_info_msg_1_%f %$(($COLUMNS - 25))<...<%~"
    fi
}

freload() { while (( $# )); do; unfunction $1; autoload -U $1; shift; done }

din()
{
    local workdir=/build
    local e opts
    opts=()

    for e in http_proxy https_proxy ftp_proxy no_proxy; do
        if [[ -n ${(P)e} ]]; then
            opts+=(-e ${e}=${(P)e})
        fi
    done

    if [[ -f /etc/localtime ]]; then
        opts+=(-v /etc/localtime:/etc/localtime:ro)
    fi

    if [[ -d /srv/mirrors ]]; then
        opts+=(-v /srv/mirrors:/srv/mirrors:ro)
    fi

    if [[ -d ~/.cache/buildenv ]]; then
        opts+=(-v ~/.cache/buildenv:/cache)
        opts+=(-e USE_CCACHE=yes)
        opts+=(-e CCACHE_DIR=/cache/ccache)
    fi

    docker run -it --rm \
        -v "$(pwd):${workdir}" \
        -w "${workdir}" \
        -h $(basename "$(pwd)") \
        -e TERM=${TERM} \
        -e BASH_ENV="${workdir}/.bashrc" \
        ${opts} \
        "$@"
}

docker-gc()
{
    local images=$(docker images -qf dangling=true)
    local volumes=$(docker volume ls -qf dangling=true)

    [[ ${images} ]] && docker rmi ${=images}
    [[ ${volumes} ]] && docker volume rm ${=volumes}
}

ssh-screen() {
    screen -t "${(@)argv[$#]/.*/}" "${SHELL}" \
        -c "GPG_TTY=\$(tty) ssh $(printf "%q " "${@}")"
}

ssh-tmux() {
    tmux new-window -n "${(@)argv[$#]/.*/}" \
        "GPG_TTY=\$(tty) ssh $(printf "%q " "${@}")"
}

compdef _ssh ssh-screen=ssh ssh-tmux=ssh

## fzf

__fzf-quoted()
{
    local item

    find . -mindepth 1 -xdev 2>/dev/null | cut -b 3- | fzf-tmux -m | \
    while read item; do
        printf '%q ' "$item"
    done
    echo
}

fzf-file-widget()
{
    LBUFFER="${LBUFFER}$(__fzf-quoted)"
    zle redisplay
}
zle -N fzf-file-widget

fzf-cdr-widget()
{
    local dir

    dir=$(cdr -l | sed 's/^[[:digit:]]*[[:space:]]*//' | fzf-tmux +m)
    if [ -n "${dir}" ]; then
        BUFFER="cd ${dir}"
        zle accept-line
    else
        zle reset-prompt
    fi
}
zle -N fzf-cdr-widget

fzf-f-widget()
{
    if [[ -n "${BUFFER}" ]]; then
        fzf-file-widget
    else
        fzf-cdr-widget
    fi
}
zle -N fzf-f-widget

bindkey '^_' fzf-f-widget


#
# Local configuration
#
[ -f ~/.zshrc_local ] && source ~/.zshrc_local


#
# Completion
#

zstyle ':completion:*' use-cache true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
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

# Array access completion
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# Misc completions
zstyle ':completion:*:cd:*' tag-order local-directories path-directories
zstyle ':completion:*:manuals' separate-sections true
