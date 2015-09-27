#
# .profile:
#       sh configuration
#

umask 022

case $(uname) in
    NetBSD)
        PATH=/usr/local/bin:/usr/local/sbin:/usr/pkg/bin:/usr/pkg/sbin
        PATH=${PATH}:/bin:/sbin:/usr/bin:/usr/sbin
        PATH=${PATH}:/usr/X11R7/bin:/usr/games
        ;;
    *)
        # /usr/pkg/sbin is required because pkg_install is there.
        PATH=/usr/pkg/bin:/usr/pkg/sbin:${PATH}
        ;;
esac
export PATH=${HOME}/bin:${PATH}

export BLOCKSIZE=1k
export COLORFGBG="default;default"
export CVS_RSH=ssh
export EDITOR=vim
export LANG=en_US.UTF-8
export LC_COLLATE=C
export LESS=-cMR
export MAIL=${HOME}/Mail
export NCURSES_NO_UTF8_ACS=0
export PAGER=less
export PERL_BADLANG=0

export ENV=${HOME}/.shrc

[ -f ~/.profile_local ] && . ~/.profile_local
