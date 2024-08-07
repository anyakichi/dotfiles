ls --color=auto >/dev/null 2>&1 && alias ls='ls --color=auto'
command -v exa &>/dev/null && \
    alias ls='exa --sort Filename --group-directories-first'
command -v eza &>/dev/null && \
    alias ls='eza --sort Filename --group-directories-first'
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
alias mutt="PINENTRY_USER_DATA=curses mutt"
alias neomutt="PINENTRY_USER_DATA=curses neomutt"
alias vimdiff='vim +next "+execute \"DirDiff\" argv(0) argv(1)"'
alias ag='ag --pager "less -FRX"'
alias picocom='picocom -e \\'
alias d=fcd
alias o=rifle
alias g=fghq

alias_alt() { command -v "$2" &>/dev/null && alias $1="${${@:2}}" }
alias_alt mutt neomutt
alias_alt top htop
alias_alt top btm
alias_alt vi vim
alias_alt vi nvim
alias_alt vim nvim

alias din='din ${DIN_OPTS[@]}'

cpr() {
    rsync -a -hh --partial --info=stats1,progress2 --modify-window=1 "$@"
}

mvr() {
    rsync -a -hh --partial --info=stats1,progress2 --modify-window=1 --remove-source-files "$@"
}

command -v jq &>/dev/null &&
jq() {
    if [[ -t 1 ]]; then
        command jq -C "$@" | less -RMFXKS
    else
        command jq "$@"
    fi
}

rg() {
    if command -v rg &>/dev/null; then
        if [[ -t 1 ]]; then
            command rg -S --color=always "$@" | less -RMFXKS
        else
            command rg -S "$@"
        fi
    else
        if [[ -t 1 ]]; then
            command grep --color=always "$@" | less -RMFXKS
        else
            command grep "$@"
        fi
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

st() {
    if [[ -t 1 ]]; then
        tmux new-window -n "${(@)argv[$#]/.*/}" \
            "GPG_TTY=\$(tty) command s $(printf "%q " "${@}")"
    else
        command s "$@"
    fi
}

ssht() {
    if [[ -t 1 ]]; then
        tmux new-window -n "${(@)argv[$#]/.*/}" \
            "GPG_TTY=\$(tty) command ssh $(printf "%q " "${@}")"
    else
        command ssh "$@"
    fi
}

waypipet() {
    if [[ -t 1 && $1 == ssh && $# == 2 ]]; then
        tmux new-window -n "${(@)argv[$#]/.*/}" \
            "GPG_TTY=\$(tty) command waypipe $(printf "%q " "${@}")"
    else
        command waypipe "$@"
    fi
}

if [[ -n "${TMUX}" ]]; then
    alias s=st
    alias ssh=ssht
    alias waypipe=waypipet
fi

# Global aliases
alias -g C='|tclip'
alias -g G='|rg'
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
