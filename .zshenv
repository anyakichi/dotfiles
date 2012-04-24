#
# dot.zshenv:
#	Zsh environment
#

#
# Resource limits
#
unlimit
limit stacksize 8192
limit -s

umask 022


#
# Search path
#
case $OSTYPE in
	netbsd*)
		path=(
		    /usr/local/bin /usr/local/sbin /usr/pkg/bin /usr/pkg/sbin
		    /bin /sbin /usr/bin /usr/sbin /usr/X11R7/bin /usr/games
		    ${path}
		)
		;;
	*)
		path=(/usr/pkg/bin /usr/pkg/sbin ${path})
		;;
esac
typeset -U path
export PATH


#
# Environment variables
#
export BLOCKSIZE=1k
export COLORFGBG="default;default"
export CVS_RSH=ssh
export EDITOR=vim
export GPG_TTY=`tty`
export LANG=en_US.UTF-8
export LESS=-cM
export MAIL=${HOME}/Mail
export PAGER=less
export PERL_BADLANG=0

# Load gpg-agent configuration
if [ -f ~/.gpg-agent-info ]; then
	. ~/.gpg-agent-info
	export GPG_AGENT_INFO
	export SSH_AUTH_SOCK
fi
