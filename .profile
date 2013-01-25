#
# dot.profile:
#	Sh configuration
#

start_gpgagent()
{
	which gpg-agent 2>&1 >/dev/null || return

	_info="${HOME}/.gpg-agent-info"

	if [ -f "${_info}" ]; then
		. "${_info}"
		export GPG_AGENT_INFO
		export SSH_AUTH_SOCK
	fi

	_pid=$(echo ${GPG_AGENT_INFO} |sed -e 's/.*gpg-agent:\([^:]*\):.*$/\1/')
	if [ "x$(ps -p ${_pid} -o comm=)" = "xgpg-agent" ]; then
		return
	fi

        eval $(gpg-agent --daemon --write-env-file "${_info}")
}

start_gpgagent

[ -f ~/.profile_local ] && . ~/.profile_local
