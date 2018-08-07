#
# gpg-agent.sh
#       gpg-agent setup for bash and zsh
#

start_gpgagent()
{
    local _info

    which gpg-agent >/dev/null 2>&1 || return

    _info="${HOME}/.cache/gpg-agent-info"

    if ! gpg-connect-agent /bye >/dev/null 2>&1; then
        # gnupg 2.0 does not start gpg-agent at gpg-connect-agent.
        gpg-agent --daemon --write-env-file "${_info}" >/dev/null
    fi

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
    elif [ -f "${_info}" ]; then
        # gnupg 2.0 compatibility
        . "${_info}"
        export GPG_AGENT_INFO
    fi

    export GPG_TTY=$(tty)
    export PINENTRY_USER_DATA="USE_CURSES=1"
    gpg-connect-agent updatestartuptty /bye >/dev/null
}

start_gpgagent
