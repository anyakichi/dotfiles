if [ $(id -u) = $(id -g) -a $(id -un) = $(id -gn) -a \
     $(id -gn) = $(ls -ld ${HOME} | awk '{print $4}') ]; then
    umask 002
else
    umask 022
fi

case $(uname) in
    NetBSD)
        PATH=/usr/local/bin:/usr/local/sbin:/usr/pkg/bin:/usr/pkg/sbin
        PATH=${PATH}:/bin:/sbin:/usr/bin:/usr/sbin
        PATH=${PATH}:/usr/X11R7/bin:/usr/games
        ;;
    Darwin)
        PATH=/usr/local/opt/coreutils/libexec/gnubin:${PATH}
        ;;
    *)
        # /usr/pkg/sbin is required because pkg_install is there.
        PATH=/usr/pkg/bin:/usr/pkg/sbin:${PATH}
        ;;
esac

export BLOCKSIZE=1k
export CVS_RSH=ssh
export EDITOR=vim
export GOPATH=${HOME}/.go
export LANG=en_US.UTF-8
export LC_COLLATE=C
export LESS=-cMR
export NCURSES_NO_UTF8_ACS=0
export PAGER=less
export QUOTING_STYLE=literal

export PIPENV_VENV_IN_PROJECT=1

export FZF_DEFAULT_COMMAND="find . -mindepth 1 -xdev -type f 2>/dev/null | cut -b 3-"
export FZF_DEFAULT_OPTS="--exact --height 40% --layout=reverse --inline-info"

export PATH=${HOME}/bin:${HOME}/.local/bin:${HOME}/.cargo/bin:${GOPATH}/bin:${PATH}


[ -f ~/.profile_local ] && . ~/.profile_local
