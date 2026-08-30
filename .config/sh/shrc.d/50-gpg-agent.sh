#!/bin/sh

setup_gpg_agent() {
    command -v gpg-agent >/dev/null 2>&1 || return

    gpgconf --launch gpg-agent >/dev/null 2>&1

    ssh_sock=$(gpgconf --list-dirs agent-ssh-socket 2>/dev/null)
    if [ -S "$ssh_sock" ]; then
        if [ -z "$SSH_CONNECTION" ] || [ -z "$SSH_AUTH_SOCK" ]; then
            unset SSH_AGENT_PID
            export SSH_AUTH_SOCK="$ssh_sock"
        fi
    fi

    GPG_TTY=$(tty)
    export GPG_TTY

    if [ -n "$TMUX_PANE" ]; then
        PINENTRY_USER_DATA="tmux:$TMUX_PANE"
    else
        PINENTRY_USER_DATA=curses
    fi
    export PINENTRY_USER_DATA

    gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
}

case "$-" in
*i*)
    setup_gpg_agent
    ;;
esac
