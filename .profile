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
export LANG=en_US.UTF-8
export LESS=-cMR
export MAIL=${HOME}/Mail
export NCURSES_NO_UTF8_ACS=0
export PAGER=less
export PERL_BADLANG=0

start_gpgagent()
{
	local _info

	which gpg-agent >/dev/null 2>&1 || return

	export GPG_TTY=$(tty)

	unset GPG_AGENT_INFO
	gpg-connect-agent /bye >/dev/null 2>&1

	if [ $? = 0 ]; then
		# gnupg 2.1 or later
		unset SSH_AGENT_PID
		if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
			export SSH_AUTH_SOCK="${HOME}/.gnupg/S.gpg-agent.ssh"
		fi
	else
		# gnupg 2.0
		_info="${HOME}/.gpg-agent-info"

		if [ -f "${_info}" ]; then
			. "${_info}"
			export GPG_AGENT_INFO
			export SSH_AUTH_SOCK
		fi

		gpg-connect-agent /bye >/dev/null 2>&1 || \
		    eval $(gpg-agent --daemon --write-env-file "${_info}")
	fi

	gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
}

case "$-" in *i*)
	start_gpgagent
	;;
esac

[ -f ~/.profile_local ] && . ~/.profile_local
