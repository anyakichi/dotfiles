#
# dot.profile:
# 	Sh configuration
#

PATH=$HOME/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin:/usr/pkg/bin
PATH=${PATH}:/usr/pkg/sbin:/usr/games:/usr/local/bin:/usr/local/sbin
export PATH

umask 022
ulimit -c 0
ulimit -d 262144
ulimit -n 512
ulimit -s 8192

export BLOCKSIZE=1k
export COLORFGBG="default;default"
export CVS_RSH=ssh
export EDITOR=vim
export GPG_TTY=`tty`
export JAVA_HOME=/usr/pkg/java/sun-1.5
export LANG=en_US.UTF-8
export LESS=-cM
export MAIL=${HOME}/Mail
export PAGER=less
export PERL_BADLANG=0
export SGML_CATALOG_FILES=/usr/pkg/etc/sgml/catalog
export XML_CATALOG_FILES=/usr/pkg/etc/xml/catalog

MAILCHECK=0
WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"

# check_process pid procname
check_process()
{
        _r=$(ps x | awk "
	    BEGIN { found = 1 }
	    /defunct/ { next }
	    /${2}/ { if (\$1 == \"${1}\") { found = 0; exit } }
	    END { print found }
	")
	return ${_r}
}

# start_gpgagent args
start_gpgagent()
{
	which gpg-agent 2>&1 >/dev/null || return

	_info="${HOME}/.gpg-agent-info"
	if [ -f "${_info}" ]; then
		_pid=$(sed -e '/^GPG_AGENT_INFO/!d' \
			   -e 's/.*gpg-agent:\([^:]*\):.*$/\1/' "${_info}")
		if check_process ${_pid} "gpg-agent"; then
			cat "${_info}" | while read _line; do
				export ${_line}
			done
			return
		fi
	fi

        _args="--daemon --write-env-file '${_info}'"
        if [ -z "${DISPLAY}" ]; then
		_pinentry=$(which pinentry-curses)
		if [ ! -z ${_pinentry} ]; then
			_args="${_args} --pinentry-program ${_pinentry}"
		fi
        fi
        eval $(eval gpg-agent ${_args} "$@")
}

[ -r ~/.profile_local ] && source ~/.profile_local
