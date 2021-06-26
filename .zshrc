#
# Include common settings
#
if [ -f "${HOME}/.shrc" ]; then
    . "${HOME}/.shrc"
fi


#
# Parameters
#
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
command -v exa &>/dev/null && \
    alias ls='exa --sort Filename --group-directories-first'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias llg='ls -lg'
alias lsd='ls -ld *(-/DN)'
alias lsa='ls -ld .*'

alias cp='nocorrect cp'
alias make='nocorrect make'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias rm='nocorrect rm'

alias grep='egrep'
alias vimdiff='vim +next "+execute \"DirDiff\" argv(0) argv(1)"'
alias ag='ag --pager "less -FRX"'
alias picocom='picocom -e \\'
alias d=fcd
alias o=rifle
alias g=fghq

alias_alt() { command -v "$2" &>/dev/null && alias $1="${${@:2}}" }
alias_alt mutt neomutt
alias_alt top htop
alias_alt vi vim
alias_alt vi nvim
alias_alt vim nvim

alias din='din ${DIN_OPTS[@]}'

command -v rg &>/dev/null &&
rg() {
    if [[ -t 1 ]]; then
        command rg -S -p "$@" | less -RMFXK
    else
        command rg -S "$@"
    fi
}

command -v rifle &>/dev/null &&
rifle()
{
    command rifle "${@:-.}"
}

if [[ -n "${TMUX}" ]]; then
    ssh() {
        tmux new-window -n "${(@)argv[$#]/.*/}" \
            "GPG_TTY=\$(tty) command ssh $(printf "%q " "${@}")"
    }
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

add-zsh-hook chpwd chpwd_recent_dirs

zstyle ':chpwd:*' recent-dirs-default true
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


#
# Functions
#

preexec_tmux()
{
    eval "$(tmux show-environment -s)"
}

if [[ -n "${TMUX}" ]]; then
    add-zsh-hook preexec preexec_tmux
fi

## fzf

__fzf-ghq()
{
    setopt localoptions pipefail

    command ghq list | fzf -q "$1" --no-multi -0 -1
}

__fzf-pass()
{
    setopt localoptions pipefail

    (cd "${PASSWORD_STORE_DIR:-~/.password-store}" &&
        command find . -name '*.gpg' 2>/dev/null \
            | command sed -e 's#^\./##' -e 's/.gpg$//' \
            | fzf --no-multi -0 --expect=ctrl-o)
}

fcd()
{
    local dir

    res=("${(@f)"$(fzf-utils::_file "$1" d)"}")

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

    pids=("${(@f)"$(fzf-ps run)"}")

    if [[ ${#pids} -ne 0 ]]; then
        kill ${1:+-${1}} "${pids[@]}"
    fi
}

fpass()
{
    pass "$(__fzf-pass)"
}


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


### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

zinit light-mode for \
    anyakichi/fzf-utils \
    reegnz/jq-zsh-plugin \
    romkatv/powerlevel10k \
    zdharma/fast-syntax-highlighting \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-completions \
    zsh-users/zsh-history-substring-search

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


#
# Local configuration
#
if [ -f ~/.zshrc_local ]; then
    source ~/.zshrc_local
fi
