#!/bin/sh

start_gpgagent() {
    which gpg-agent >/dev/null 2>&1 || return

    if [ -e "${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh" ]; then
        unset SSH_AGENT_PID
        if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
            export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"
        fi
    elif [ -e "${HOME}/.gnupg/S.gpg-agent.ssh" ]; then
        unset SSH_AGENT_PID
        if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
            export SSH_AUTH_SOCK="${HOME}/.gnupg/S.gpg-agent.ssh"
        fi
    fi

    GPG_TTY=$(tty)
    export GPG_TTY
    export PINENTRY_USER_DATA=tty
    gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
}

case "$-" in
*i*)
    start_gpgagent
    ;;
esac
