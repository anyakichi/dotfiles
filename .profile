#
# dot.profile:
#	Sh configuration
#

umask 022

case $(uname) in
	NetBSD)
		PATH=/usr/local/bin:/usr/local/sbin:/usr/pkg/bin:/usr/pkg/sbin
		PATH=${PATH}:/bin:/sbin:/usr/bin:/usr/sbin
		PATH=${PATH}:/usr/X11R7/bin:/usr/games
		;;
	*)
		PATH=/usr/pkg/bin:/usr/pkg/sbin:${PATH}
		;;
esac
export PATH

export BLOCKSIZE=1k
export COLORFGBG="default;default"
export CVS_RSH=ssh
export EDITOR=vim
tty -s && export GPG_TTY=`tty`
export LANG=en_US.UTF-8
export LESS=-cMR
export MAIL=${HOME}/Mail
export NCURSES_NO_UTF8_ACS=0
export PAGER=less
export PERL_BADLANG=0

start_gpgagent()
{
	local _info _pid _comm

	which gpg-agent 2>&1 >/dev/null || return

	_info="${HOME}/.gpg-agent-info"

	if [ -f "${_info}" ]; then
		. "${_info}"
		export GPG_AGENT_INFO
		export SSH_AUTH_SOCK
	fi

	_pid=$(echo ${GPG_AGENT_INFO} |sed -e 's/.*gpg-agent:\([^:]*\):.*$/\1/')
	_comm=$(echo $(ps -p ${_pid} -o comm=) | sed -e 's/ *$//')
	if [ "x${_comm}" = "xgpg-agent" ]; then
		return
	fi

        eval $(gpg-agent --daemon --write-env-file "${_info}")
}

start_gpgagent

[ -f ~/.profile_local ] && . ~/.profile_local
