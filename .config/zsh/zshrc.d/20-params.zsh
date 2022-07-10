DIRSTACKSIZE=20

HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=20000
SAVEHIST=100000

MAILCHECK=0

if [[ $TERM == tmux-256color ]]; then
    export COLORTERM=truecolor
fi

cdpath=(~ ~/src ~/Documents)
fpath=($XDG_CONFIG_HOME/zsh/functions "${fpath[@]}")

typeset -U cdpath fpath hosts mailpath manpath path
