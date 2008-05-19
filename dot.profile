#	$Id$

PATH=$HOME/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin:/usr/pkg/bin
PATH=${PATH}:/usr/pkg/sbin:/usr/games:/usr/local/bin:/usr/local/sbin
PATH=${PATH}:/usr/pkg/java/sun-1.5/bin:/Developer/Tools
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

LOG=/var/log/httpd/access_log
WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"

[ -r ~/.profile_local ] && source ~/.profile_local
