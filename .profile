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

[ -f ~/.profile_local ] && . ~/.profile_local
