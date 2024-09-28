alias_if_exists() {
    command -v "$1" &>/dev/null && alias $1="${${@:2}}"
}

alias_alt() {
    command -v "$2" &>/dev/null && alias $1="${${@:2}}"
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
alias lsd='ls -ld *(-/DN)'
alias lst='ls --sort time'

alias cp='nocorrect cp'
alias make='nocorrect make'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias rm='nocorrect rm'

alias g=fghq
alias neomutt="PINENTRY_USER_DATA=curses neomutt"
alias o='handlr open'
alias picocom='picocom -e \\'
alias vimdiff='vim +next "+execute \"DirDiff\" argv(0) argv(1)"'

alias_if_exists jq 'pipeless jq -C'
alias_if_exists rg 'pipeless rg -S --color=always'

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
