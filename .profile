if [ $(id -u) = $(id -g) -a $(id -un) = $(id -gn) -a \
     $(id -gn) = $(ls -ld ${HOME} | awk '{print $4}') ]; then
    umask 002
else
    umask 022
fi

export BLOCKSIZE=1k
export CVS_RSH=ssh
export EDITOR=vim
command -v nvim >/dev/null 2>&1 && EDITOR=nvim
export GOPATH=${HOME}/.go
export LANG=en_US.UTF-8
export LC_COLLATE=C
export LESS=-cMR
export NCURSES_NO_UTF8_ACS=0
export PAGER=less
export QUOTING_STYLE=literal

export FZF_DEFAULT_COMMAND="fzf-file list"
export FZF_DEFAULT_OPTS="\
 --ansi --height 40% --layout=reverse --inline-info --cycle \
 --bind ctrl-g:top,ctrl-alt-g:top \
 --bind ctrl-/:toggle-preview \
 --bind alt-j:preview-down \
 --bind alt-k:preview-up \
 --bind ctrl-alt-j:down \
 --bind ctrl-alt-k:up \
 --bind alt-f:preview-page-down,ctrl-alt-f:preview-page-down \
 --bind alt-b:preview-page-up,ctrl-alt-b:preview-page-up \
 --bind alt-g:preview-top,ctrl-alt-g:preview-top \
 --bind alt-G:preview-bottom \
 --color=hl:6,fg+:253,bg+:237,hl+:6,info:2,pointer:209"
export PIPENV_VENV_IN_PROJECT=1
export XAPIAN_CJK_NGRAM=1

export PATH=${HOME}/.local/bin:${HOME}/.cargo/bin:${GOPATH}/bin:${PATH}


[ -f ~/.profile_local ] && . ~/.profile_local
