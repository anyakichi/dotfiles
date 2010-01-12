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
export JAVA_HOME=/usr/pkg/java/sun-1.5
export LANG=en_US.UTF-8
export LESS=-cM
export PAGER=less
export PERL_BADLANG=0
export SGML_CATALOG_FILES=/usr/pkg/etc/sgml/catalog
export XML_CATALOG_FILES=/usr/pkg/etc/xml/catalog

gpgagent=`which gpg-agent`
gpginfo="${HOME}/.gpg-agent-info"
if [ -x ${gpgagent} ]; then
	if [ -f "${gpginfo}" ] &&
	    kill -0 `grep GPG_AGENT_INFO "${gpginfo}" | cut -d: -f 2` \
		2> /dev/null;
	then
		. "${gpginfo}"
		export GPG_AGENT_INFO SSH_AUTH_SOCK SSH_AGENT_PID
	else
		eval `gpg-agent --daemon --enable-ssh-support \
				--write-env-file "${gpginfo}"`
	fi
fi

WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"

[ -r ~/.profile_local ] && source ~/.profile_local
