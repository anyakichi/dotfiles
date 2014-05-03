#
# dot.zshrc:
#	Zsh configuration
#

#
# Terminal setup
#
if tty -s; then
	stty -ixon
	stty status '^T' 2>/dev/null
fi


#
# Parameters
#
PROMPT='%m%# '
RPROMPT='$(my_rprompt)'

DIRSTACKSIZE=20

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

MAILCHECK=0

cdpath=(~ ~/src ~/Documents)
fpath=(~/.zfunc $fpath)
hosts=(`hostname` sopht.jp ftp.netbsd.org)
path=(~/bin ~/local/bin ~/local/sbin $path)

typeset -U cdpath fpath hosts mailpath manpath path


#
# Aliases
#
alias grep=egrep
alias mz='mutt -Z'
alias vi=vim
alias vimdiff='vim +next "+execute \"DirDiff\" argv(0) argv(1)"'

alias cp='nocorrect cp'
alias make='nocorrect make'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias rm='nocorrect rm'
alias man='LANG=C man'

alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lsd='ls -ld *(-/DN)'
alias lsa='ls -ld .*'

# Aliases for ssh
if [[ -n "${STY}" ]] then
	alias ssh=ssh-screen
elif [[ -n "${TMUX}" ]] then
	alias ssh=ssh-tmux
else
	alias ssh=ssh-wrapper
fi

# Global aliases
alias -g G='|grep'
alias -g L='|less'
alias -g LL='2>&1|less'
alias -g M='|more'
alias -g H='|head'
alias -g I='|iconv'
alias -g S='|sort'
alias -g T='|tail'
alias -g W='|wc'
alias -g X='|xargs'

# OS specific aliases
case $OSTYPE in
	darwin*)
		alias ka='open -a "Keychain Access"'
		alias ldd='otool -L'
		[ -x /usr/pkg/bin/vim ] && alias vim=/usr/pkg/bin/vim
		;;
	netbsd*)
		;;
	solaris*)
		;;
esac


#
# Options
#

# Changing Directories
setopt auto_cd auto_pushd cdable_vars
setopt pushd_ignore_dups pushd_minus pushd_silent pushd_to_home

# Completion
setopt complete_in_word

# Expansion and Grobbing
setopt extended_glob numeric_glob_sort

# History
setopt extended_history
setopt hist_ignore_alldups hist_ignore_dups hist_ignore_space hist_reduce_blanks
setopt inc_append_history

# Input/Output
setopt correct list_packed

# Prompt
setopt prompt_subst
setopt transient_rprompt

# Zle
setopt no_beep


#
# Modules
#
zmodload -i zsh/complist
zmodload -a zsh/stat stat
zmodload -a zsh/zprof zprof


#
# Key bindings
#
bindkey -e
bindkey ' ' magic-space
bindkey '^D' list-choices
bindkey '^I' complete-word
bindkey -M menuselect \
	'^P' up-line-or-history '^N' down-line-or-history \
	'^B' backward-char '^F' forward-char
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward


#
# Plugins
#
autoload -Uz add-zsh-hook compinit is-at-least zmv
compinit


# cdr: it must be loaded before zaw to use zaw-cdr
autoload -Uz cdr chpwd_recent_dirs

zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-max 1000
zstyle ':chpwd:*' recent-dirs-prune "pattern:^${HOME}$"
zstyle ':completion:*' recent-dirs-insert always

add-zsh-hook chpwd chpwd_recent_dirs


# antigen
if [[ -f $HOME/.zsh/antigen/antigen.zsh ]]; then
    ADOTDIR=$HOME/.zsh/antigen
    source $ADOTDIR/antigen.zsh

    antigen bundle anyakichi/zaw --branch=filter-fix

    antigen apply
fi


# edit-command-line
autoload -Uz edit-command-line
zle -N edit-command-line

bindkey '^Xe' edit-command-line
bindkey '^X^E' edit-command-line


# factorize-last-two-args
autoload -Uz factorize-last-two-args
zle -N factorize-last-two-args
bindkey '^X^F' factorize-last-two-args


# select-word-style
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /:@+|"
zstyle ':zle:*' word-style unspecified


# vcs_info
autoload -Uz vcs_info

zstyle ':vcs_info:*' max-exports 4
zstyle ':vcs_info:*' formats '%s' '%b' '%R'
zstyle ':vcs_info:*' actionformats '%s' '%b|%a' '%R'

add-zsh-hook precmd vcs_info


# zaw
autoload -Uz filter-select
filter-select -i

bindkey -M filterselect '^V' quoted-insert
bindkey -M filterselect '^Y' accept-search

zstyle ':filter-select:highlight' error fg=196,bold
zstyle ':filter-select:highlight' marked fg=111
zstyle ':filter-select:highlight' matched underline
zstyle ':filter-select:highlight' selected bg=238
zstyle ':filter-select:highlight' title fg=110,bold
zstyle ':filter-select' max-lines 3
zstyle ':filter-select' case-insensitive yes
zstyle ':filter-select' extended-search yes
zstyle ':filter-select' rotate-list yes
zstyle ':filter-select' use-cursor-line yes

bindkey '^R' zaw-history
bindkey '^_' zaw-cdr


#
# Functions
#

my_rprompt()
{
        if [[ "$vcs_info_msg_2_" = "$HOME" || -z "$vcs_info_msg_2_" ]]; then
		echo -n "%$(($COLUMNS - 15))<...<%~"
        else
		echo -n "%F{green}$vcs_info_msg_0_:$vcs_info_msg_1_%f %$(($COLUMNS - 25))<...<%~"
        fi
}

setenv() { typeset -x "${1}${1:+=}${(@)argv[2,$#]}" }  # csh compatibility
freload() { while (( $# )); do; unfunction $1; autoload -U $1; shift; done }

which pgrep >/dev/null 2>&1 || \
pgrep() {
	ps axco pid,command | grep ${1} | awk '{print $1}'
}

ssh-screen() {
	screen -t ${(@)argv[$#]/.*/} ${SHELL} -c "$(whence -cp ssh) $@"
}

ssh-tmux() {
	tmux new-window -n ${(@)argv[$#]/.*/} "${SHELL} -c '$(whence -cp ssh) $*'"
}

ssh-wrapper() {
	eval $(whence -cp ssh) "$@"
}

compdef _ssh ssh-screen=ssh ssh-tmux=ssh ssh-wrapper=ssh


#
# Local configuration
#
[ -f ~/.zshrc_local ] && source ~/.zshrc_local


#
# Completion
#

zstyle ':completion:*' use-cache true
zstyle ':completion:*:default' menu select=2

# Completers to use
zstyle ':completion:*::::' completer _expand _complete _match _prefix _ignored \
	_correct

# Match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Expand completer
zstyle ':completion:*:expand:*' tag-order 'all-expansions expansions'
zstyle ':completion:*:expand:*' group-order all-expansions expansions

# Ignore patterns
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o'
zstyle ':completion:*:functions' ignored-patterns '_*'

# Formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# Array access completion
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# Misc completions
zstyle '*' hosts $hosts
zstyle ':completion:*:cd:*' tag-order local-directories path-directories
zstyle ':completion:*:manuals' separate-sections true
