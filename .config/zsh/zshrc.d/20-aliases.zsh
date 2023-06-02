ls --color=auto >/dev/null 2>&1 && alias ls='ls --color=auto'
command -v exa &>/dev/null && \
    alias ls='exa --sort Filename --group-directories-first'
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'
alias llg='ls -lg'
alias llt='ls -l --sort time'
alias lsa='ls -ld .*'
alias lsd='ls -ld *(-/DN)'
alias lst='ls --sort time'

alias cp='nocorrect cp'
alias make='nocorrect make'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias rm='nocorrect rm'

alias grep='grep -E'
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

command -v jq &>/dev/null &&
jq() {
    if [[ -t 1 ]]; then
        command jq -C "$@" | less -RMFXKS
    else
        command jq "$@"
    fi
}

command -v rg &>/dev/null &&
rg() {
    if [[ -t 1 ]]; then
        command rg -S -p "$@" | less -RMFXKS
    else
        command rg -S "$@"
    fi
}

command -v rifle &>/dev/null &&
rifle()
{
    command rifle "${@:-.}"
}

if [ "$(tmux -V | awk 'NR==1 {print ($2+0 < 3.1)}')" = 1 ]; then
    alias tmux="tmux -f ~/.config/tmux/tmux.conf"
fi

if [[ -n "${TMUX}" ]]; then
    ssh() {
        tmux new-window -n "${(@)argv[$#]/.*/}" \
            "GPG_TTY=\$(tty) command ssh $(printf "%q " "${@}")"
    }

    waypipe() {
        if [[ $1 == ssh && $# == 2 ]]; then
            tmux new-window -n "${(@)argv[$#]/.*/}" \
                "GPG_TTY=\$(tty) command waypipe $(printf "%q " "${@}")"
        else
            command waypipe "$@"
        fi
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
