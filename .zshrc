#
# Include common settings
#
if [ -f "${HOME}/.shrc" ]; then
    . "${HOME}/.shrc"
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
fpath=(~/.zsh/functions "${fpath[@]}")

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
command -v vim > /dev/null 2>&1 && alias vi=vim
alias vimdiff='vim +next "+execute \"DirDiff\" argv(0) argv(1)"'
alias mz='mutt -Z'
alias ag='ag --pager "less -FRX"'
alias picocom='picocom -e \\'
alias d=fcd
alias o=rifle
alias r=rifle
command -v open >/dev/null 2>&1 || alias open=xdg-open

alias din='din ${DIN_OPTS[@]}'
alias gg='fghq'

if [[ -n "${STY}" ]]; then
    alias ssh=ssh-screen
elif [[ -n "${TMUX}" ]]; then
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
source ~/.zsh/cdr.zsh

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
    output=("${(ps:\t:)output}")
    left=${output[1]}
    right=${output[2]}
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
    curl -L git.io/antigen > "$HOME/.zsh/antigen.zsh"
}

if [[ -f $HOME/.zsh/antigen.zsh ]]; then
    source "$HOME/.zsh/antigen.zsh"

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
    if [[ -n "${vcs_info_msg_4_}" ]]; then
        msg="${msg:- }%F{231}%K{9}${vcs_info_msg_4_}%k%f"
    fi
    if [[ -n "${vcs_info_msg_0_}" ]]; then
        msg="${msg:- }%K{4}${vcs_info_msg_0_}%k"
    fi
    if [[ "${vcs_info_msg_1_}" == *"%k"* ]]; then
        msg="${msg:- }${vcs_info_msg_1_%\%k*}%k"
    fi
    if [[ -n "${vcs_info_msg_2_}" ]]; then
        path="${vcs_info_msg_2_/#${HOME:A}/~}"
        if [[ -n "${vcs_info_msg_3_}" && ${vcs_info_msg_3_} != "." ]]; then
            path="%F{green}${path}/%f${vcs_info_msg_3_}"
        else
            path="%F{green}${path}%f"
        fi
    fi
    echo -n "%$((COLUMNS - 16))<..<${path}${msg}"
}

preexec_tmux()
{
    eval "$(tmux show-environment -s)"
}

if [[ -n "${TMUX}" ]]; then
    add-zsh-hook preexec preexec_tmux
fi

rifle()
{
    command rifle "${@:-.}"
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

    if [[ "${@[-1]}" == '.' ]]; then
        opts+=(-uu)
    elif [[ $(command git rev-parse --show-toplevel) == "${HOME}" ]]; then
        opts+=(-u)
    fi

    if command -v rg &>/dev/null && [[ -t 1 ]]; then
        command rg -p "${opts[@]}" "$@" | less -RMFXK
    else
        command rg "$@"
    fi
}

## fzf

__longest_dir()
{
    local dir="$1"

    while true; do
        if [[ -d ${dir} ]]; then
            echo "${dir}"
            break
        fi
        if [[ ! ${dir} =~ / ]]; then
            break
        fi
        dir=${dir%/*}
    done
}

__fzf-find()
{
    setopt localoptions pipefail
    local dir opts

    dir="$(__longest_dir "$1")"

    if [[ -n "${dir}" ]]; then
        opts=(-q "${1:(($#dir + 1))}")
        if [[ ${dir} =~ /$ ]]; then
            opts+=(--prompt "${dir}> " )
        else
            opts+=(--prompt "${dir}/> " )
        fi
    else
        opts=(-q "$1")
    fi

    shift

    (
        cd "${dir:-.}" &&
        "$@" \
            | command fzf -m -0 --print-query --expect=ctrl-o "${opts[@]}" \
            | command sed -e "3,\$s|^|${dir}|"
    )
}

__fzf-f()
{
    __fzf-find "$1" fzf-find
}

__fzf-d()
{
    __fzf-find "$1" fzf-find d
}

__fzf-ghq()
{
    setopt localoptions pipefail

    command ghq list | command fzf -q "$1" +m -0 -1
}

__fzf-history()
{
    setopt localoptions pipefail

    fc -rln 1 \
        | command fzf -q "$1" +m +s -0 --print-query \
            --expect=ctrl-q \
            --expect=ctrl-y \
            --preview "echo {}" \
            --preview-window bottom:3:wrap:hidden \
            --bind 'ctrl-v:toggle-preview' \
            --bind 'ctrl-r:down'
}

__fzf-pass()
{
    setopt localoptions pipefail

    (cd "${PASSWORD_STORE_DIR:-~/.password-store}" &&
        command find . -name '*.gpg' 2>/dev/null \
            | command sed -e 's#^\./##' -e 's/.gpg$//' \
            | command fzf +m -0 --expect=ctrl-o)
}

__fzf-ps()
{
    setopt localoptions pipefail
    local ps_cmd

    ps_cmd=(command ps -f)
    if [[ ${UID} -eq 0 ]]; then
        ps_cmd+=(-e)
    else
        ps_cmd+=(-u "${UID}")
    fi

    "${ps_cmd[@]}" | command sed 1d | command fzf -m | command awk '{print $2}'
}

fcd()
{
    local dir

    res=("${(@f)"$(__fzf-d "$1")"}")

    if [[ ${#res} -ge 3 ]]; then
        cd "${res[3]}" || return
    fi
}

fghq()
{
    local dir
    dir="$(__fzf-ghq "$1")" && cd "$(command ghq root)/${dir}" || return
}

fkill()
{
    local pids

    pids=("${(@f)"$(__fzf-ps)"}")

    if [[ ${#pids} -ne 0 ]]; then
        kill ${1:+-${1}} "${pids[@]}"
    fi
}

fpass()
{
    pass "$(__fzf-pass)"
}

fzf-file-widget()
{
    setopt localoptions extended_glob pipefail
    local key i res ret

    res=("${(@f)"$(__fzf-f "${LBUFFER##*[[:space:]]##}")"}")
    ret=$?

    if [[ ${#res} -ge 3 ]]; then
        key="${res[2]}"
        shift 2 res

        LBUFFER="${LBUFFER%%[^[:space:]]##}"
        for i in "${res[@]}"; do
            LBUFFER+="${(q)i} "
        done
    elif [[ ${#res} -ge 2 ]]; then
        LBUFFER="${LBUFFER%%[^[:space:]]##}"
        LBUFFER+=${(q)res[1]}
    fi

    zle reset-prompt

    if [[ "${key}" == "ctrl-o" ]]; then
        zle accept-line
    fi

    return ${ret}
}
zle -N fzf-file-widget

fzf-cdr-widget()
{
    setopt localoptions pipefail
    local dir

    dir=$(__fzf-cdr \
            | fzf +m \
                --bind 'esc:reload:zsh -c "source ~/.zsh/cdr.zsh; __fzf-cdr"' \
                --bind 'ctrl-/:reload:fzf-find d')
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

fzf-history-widget()
{
    setopt localoptions pipefail
    local key res ret

    res=("${(@f)"$(__fzf-history "${LBUFFER}")"}")
    ret=$?

    if [[ ${#res} -ge 3 && ${res[2]} != "ctrl-q" ]]; then
        key="${res[2]}"
        BUFFER="${res[3]}"
        CURSOR=$#BUFFER
    elif [[ ${#res} -ge 2 ]]; then
        key="${res[2]}"
        BUFFER="${res[1]}"
        CURSOR=$#BUFFER
    fi

    zle reset-prompt

    if [[ -z "${key}" ]]; then
        zle accept-line
    fi

    return ${ret}
}
zle -N fzf-history-widget

bindkey '^_' fzf-f-widget
command -v fzf &>/dev/null && bindkey '^R' fzf-history-widget


#
# Completion
#

zstyle ':completion:*' use-cache true
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
