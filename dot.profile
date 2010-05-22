#
# dot.profile:
# 	Sh configuration
#

stty status '^T' -ixon

ulimit -d 262144
ulimit -n 512
ulimit -s 8192

umask 022

PATH=$HOME/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin:/usr/pkg/bin
PATH=${PATH}:/usr/pkg/sbin:/usr/games:/usr/local/bin:/usr/local/sbin
export PATH

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
export SGML_CATALOG_FILES=/usr/pkg/etc/sgml/catalog
export XML_CATALOG_FILES=/usr/pkg/etc/xml/catalog

[ -x `which keychain` ] && eval `keychain -q --eval --timeout 10`

[ -f ~/.profile_local ] && . ~/.profile_local
