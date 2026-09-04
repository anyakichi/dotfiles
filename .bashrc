# Fallback configuration for bash when zsh is unavailable.

. ~/.config/sh/shrc

# Options
shopt -s autocd cdspell checkwinsize cmdhist extglob globstar histappend
shopt -s no_empty_cmd_completion

bind 'set bell-style none'
bind 'set colored-stats on'
bind 'set show-all-if-ambiguous on'

# Parameters
mkdir -p "${XDG_STATE_HOME:-$HOME/.local/state}/bash"
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/bash/history"
HISTSIZE=20000
HISTFILESIZE=100000
HISTCONTROL=ignoreboth:erasedups
HISTTIMEFORMAT='%F %T '

CDPATH=.:~:~/src:~/Documents
unset MAILCHECK

# Prompt
PS1='\[\e[1;32m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\]\$ '
case "$TERM" in
    xterm*|tmux*|screen*|foot*|alacritty|wezterm)
        PS1='\[\e]0;\u@\h:\w\a\]'"$PS1"
        ;;
esac
__prompt_hook() {
    history -a
    # Refresh environment from tmux.
    [[ -n $TMUX ]] && eval "$(tmux show-environment -s)"
}
PROMPT_COMMAND=__prompt_hook

# Completion
if ! shopt -oq posix; then
    if [[ -r /usr/share/bash-completion/bash_completion ]]; then
        . /usr/share/bash-completion/bash_completion
    elif [[ -r /etc/bash_completion ]]; then
        . /etc/bash_completion
    fi
fi

# Aliases
alias_alt() {
    command -v "$2" >/dev/null 2>&1 && alias "$1=${*:2}"
}

ls --color=auto >/dev/null 2>&1 && alias ls='ls --color=auto'
alias_alt ls exa --sort Filename --group-directories-first
alias_alt ls eza --sort Filename --group-directories-first
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'
alias llg='ls -lg'
alias llt='ls -l --sort time'
alias lsa='ls -ld .*'
alias lst='ls --sort time'

alias g=fghq
alias o='handlr open'
alias picocom='picocom -e \\'
alias zj=zellij

if command -v systemd-run >/dev/null 2>&1; then
    alias tmux='systemd-run -q --user --scope tmux'
    alias tmuxp='systemd-run -q --user --scope tmuxp'
    alias zellij='systemd-run -q --user --scope zellij'
fi

alias_alt fd fdfind
alias_alt mutt neomutt
alias_alt top htop
alias_alt top btm
alias_alt vi vim
alias_alt vi nvim
alias_alt vim nvim

command -v jq >/dev/null 2>&1 &&
jq() {
    if [[ -t 1 ]]; then
        command jq -C "$@" | less -RMFXKS
    else
        command jq "$@"
    fi
}

command -v rg >/dev/null 2>&1 &&
rg() {
    if [[ -t 1 ]]; then
        command rg -S --color=always "$@" | less -RMFXKS
    else
        command rg -S "$@"
    fi
}

cpr() {
    rsync -a -hh --partial --info=stats1,progress2 --modify-window=1 "$@"
}

mvr() {
    rsync -a -hh --partial --info=stats1,progress2 --modify-window=1 --remove-source-files "$@"
}

fghq() {
    local dir
    dir="$(command ghq list | fzf -q "$1" --no-multi -0 -1 --scheme=path)" &&
        cd "$(command ghq root)/${dir}" || return
}

# Tools
command -v direnv >/dev/null 2>&1 && eval "$(direnv hook bash)"
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init bash)"

# Prefer fzf-utils; fall back to fzf's own key bindings.
for f in "${XDG_DATA_HOME:-$HOME/.local/share}/zinit/plugins/anyakichi---fzf-utils/fzf-utils.bash" \
         "${XDG_DATA_HOME:-$HOME/.local/share}/fzf-utils/fzf-utils.bash" \
         "$HOME/src/github.com/anyakichi/fzf-utils/fzf-utils.bash"; do
    [[ -r $f ]] && . "$f" && break
done
unset f

if type -t fzf-utils::file-widget >/dev/null; then
    fcd() {
        local dir
        dir=$(fzf-file run --no-multi -q "$1" -- d) && cd "$dir" || return
    }

    if command -v zoxide >/dev/null 2>&1; then
        zoxide-zi-widget() {
            if [[ -n $READLINE_LINE ]]; then
                fzf-utils::file-widget
            else
                __zoxide_zi
            fi
        }
        bind -x '"\C-_": zoxide-zi-widget'
    else
        bind -x '"\C-_": fzf-utils::file-widget'
    fi
elif command -v fzf >/dev/null 2>&1; then
    if fzf --bash >/dev/null 2>&1; then
        eval "$(fzf --bash)"
    else
        for f in /usr/share/fzf/key-bindings.bash /usr/share/fzf/completion.bash \
                 /usr/share/doc/fzf/examples/key-bindings.bash \
                 /usr/share/doc/fzf/examples/completion.bash; do
            [[ -r $f ]] && . "$f"
        done
        unset f
    fi
fi
