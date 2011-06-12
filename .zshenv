#
# dot.zshenv:
# 	Zsh environment
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
PATH=${PATH}:/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin:/usr/pkg/bin
PATH=${PATH}:/usr/pkg/sbin:/usr/games:/usr/local/bin:/usr/local/sbin
PATH=${HOME}/bin:${HOME}/local/bin:${PATH}
export PATH
typeset -U path


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
