#
# Include common settings
#
if [ -f ${HOME}/.shrc ]; then
    . ${HOME}/.shrc
fi


#
# Parameters
#
PROMPT='%m%(?..%F{red})%#%f '
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
alias picocom='picocom -e \\'
which open >/dev/null 2>&1 || alias open=xdg-open

alias din='din ${DIN_OPTS[@]}'

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

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' use-simple true
zstyle ':vcs_info:*' max-exports 5
zstyle ':vcs_info:git:*' formats '%b' '%m' '%R' '%S'
zstyle ':vcs_info:git:*' actionformats '%b' '%m' '%R' '%S' '%a'
zstyle ':vcs_info:*' formats '%s:%b' '%m' '%R' '%S'
zstyle ':vcs_info:*' actionformats '%s:%b' '%m' '%R' '%S' '%a'

+vi-git-left-right-count() {
    local output left right
    output=$(command git rev-list --left-right --count HEAD...@'{u}' 2>/dev/null)
    output=(${(ps:\t:)output})
    left=$output[1]
    right=$output[2]
    if [[ ${left} -gt 0 ]]; then
        hook_com[misc]+="%K{28}⇡${left}%k"
    fi
    if [[ ${right} -gt 0 ]]; then
        hook_com[misc]+="%K{88}⇣${right}%k"
    fi
}

+vi-git-stash-count() {
    local count

    if [[ -s $(command git rev-parse --git-dir)/refs/stash ]]; then
        count=$(command git stash list 2>/dev/null | wc -l)
        hook_com[misc]+="%K{242}↶${count// /}%k"
    fi
}

zstyle ':vcs_info:git+post-backend:*' hooks git-left-right-count git-stash-count

add-zsh-hook precmd vcs_info

## antigen
install_antigen()
{
    curl -L git.io/antigen > $HOME/.zsh/antigen.zsh
}

if [[ -f $HOME/.zsh/antigen.zsh ]]; then
    source $HOME/.zsh/antigen.zsh

    antigen bundle zsh-users/zsh-autosuggestions
    antigen bundle zsh-users/zsh-completions
    antigen bundle zsh-users/zsh-history-substring-search

    # zsh-syntax-highlighting must be sourced after all ZLE widget created
    antigen bundle zsh-users/zsh-syntax-highlighting

    ZSH_AUTOSUGGEST_USE_ASYNC=1

    typeset -A ZSH_HIGHLIGHT_STYLES
    ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=9'
    ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=12'
    ZSH_HIGHLIGHT_STYLES[builtin]='fg=12'
    ZSH_HIGHLIGHT_STYLES[function]='fg=6'
    ZSH_HIGHLIGHT_STYLES[precommand]='fg=11'
    ZSH_HIGHLIGHT_STYLES[path]='fg=10'
    ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=10,underline'
    ZSH_HIGHLIGHT_STYLES[globbing]='fg=none'
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=3'
    ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=10'
    ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=10'
    ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=10'
    ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=5'
    ZSH_HIGHLIGHT_STYLES[rc-quote]='fg=11'
    ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=11'
    ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=11'
    ZSH_HIGHLIGHT_STYLES[arg0]='fg=default,bold'

    bindkey -M emacs '^P' history-substring-search-up
    bindkey -M emacs '^N' history-substring-search-down
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down

    antigen apply
fi


#
# Functions
#

my_rprompt()
{
    local msg path="%~"
    if [[ ${vcs_info_msg_4_} ]]; then
        msg="${msg:- }%F{231}%K{9}${vcs_info_msg_4_}%k%f"
    fi
    if [[ ${vcs_info_msg_0_} ]]; then
        msg="${msg:- }%K{4}${vcs_info_msg_0_}%k"
    fi
    if [[ ${vcs_info_msg_1_} == *"%k"* ]]; then
        msg="${msg:- }${vcs_info_msg_1_%\%k*}%k"
    fi
    if [[ ${vcs_info_msg_2_} ]]; then
        path="${vcs_info_msg_2_/#${HOME:A}/~}"
        if [[ ${vcs_info_msg_3_} && ${vcs_info_msg_3_} != "." ]]; then
            path="%F{green}${path}/%f${vcs_info_msg_3_}"
        else
            path="%F{green}${path}%f"
        fi
    fi
    echo -n "%$(($COLUMNS - 16))<..<${path}${msg}"
}

freload() { while (( $# )); do; unfunction $1; autoload -U $1; shift; done }

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

rg() {
    local opts
    opts=()

    if [[ ${@[-1]} == '.' ]]; then
        opts+=(-uu)
    elif [[ $(command git rev-parse --show-toplevel) == ${HOME} ]]; then
        opts+=(-u)
    fi

    if [[ -t 1 ]]; then
        command rg -p "${opts[@]}" "$@" | less -RMFXK
    else
        command rg "$@"
    fi
}

gi() {
    curl -sL https://www.gitignore.io/api/${@}
}

## fzf

__fzf-quoted()
{
    setopt localoptions pipefail
    local item

    command find ${1:-.} -mindepth 1 -xdev 2>/dev/null \
        | command sed 's#^\./##' | fzf-tmux -m | \
    while read item; do
        echo -n "${(q)item} "
    done
    local ret=$?
    echo
    return $ret
}

fzf-file-widget()
{
    LBUFFER="${LBUFFER%%[^[:space:]]##}$(__fzf-quoted ${LBUFFER##*[[:space:]]##})"
    local ret=$?
    zle reset-prompt
    return $ret
}
zle -N fzf-file-widget

fzf-cdr-widget()
{
    setopt localoptions pipefail
    local dir

    dir=$(cdr -l | sed 's/^[[:digit:]]*[[:space:]]*//' | fzf-tmux +m)
    local ret=$?
    if [ -n "${dir}" ]; then
        BUFFER="cd ${dir}"
        zle accept-line
    else
        zle reset-prompt
    fi
    return $ret
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


#
# Local configuration
#
if [ -f ~/.zshrc_local ]; then
    source ~/.zshrc_local
fi
