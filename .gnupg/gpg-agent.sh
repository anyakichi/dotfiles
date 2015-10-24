#
# gpg-agent.sh
#       gpg-agent setup for bash and zsh
#

start_gpgagent()
{
    local _info

    which gpg-agent >/dev/null 2>&1 || return

    _info="${HOME}/.config/gpg-agent-info"

    if ! gpg-connect-agent /bye >/dev/null 2>&1; then
        # gnupg 2.0 does not start gpg-agent at gpg-connect-agent.
        gpg-agent --daemon --write-env-file "${_info}" >/dev/null
    fi

    # gnupg 2.0 compatibility
    if [ -f "${_info}" ]; then
        . "${_info}"
        export GPG_AGENT_INFO
    fi

    if [ -e "${HOME}/.gnupg/S.gpg-agent.ssh" ]; then
        unset SSH_AGENT_PID
        if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
                export SSH_AUTH_SOCK="${HOME}/.gnupg/S.gpg-agent.ssh"
        fi
    fi

    export GPG_TTY=$(tty)
    gpg-connect-agent updatestartuptty /bye >/dev/null
}

start_gpgagent