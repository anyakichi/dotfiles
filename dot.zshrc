#
# dot.zshrc:
# 	Zsh configuration
#

#
# Terminal setup
#
if tty -s; then
	stty -ixon
	stty status '^T' 2>/dev/null
fi


#
# Resource limits
#
unlimit
limit stacksize 8192
limit -s


#
# Parameters
#
PROMPT='%m%# '
RPROMPT=' %~'

DIRSTACKSIZE=20

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

MAILCHECK=0

cdpath=(~ ~/src ~/Documents)
fpath=(~/.zfunc $fpath)
hosts=(`hostname` sopht.jp ftp.netbsd.org)

typeset -U cdpath fpath hosts mailpath manpath path


#
# Aliases
#
alias mz='mutt -Z'
alias vi=vim
alias grep=egrep

alias cp='nocorrect cp'
alias make='nocorrect make'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias rm='nocorrect rm'

alias j=jobs
alias pu=pushd
alias po=popd
alias d='dirs -v'
alias h=history

alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lsd='ls -ld *(-/DN)'
alias lsa='ls -ld .*'

alias mq='hg -R $(hg root)/.hg/patches'

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
setopt extended_glob

# History
setopt inc_append_history hist_ignore_alldups hist_ignore_dups
setopt hist_reduce_blanks

# Input/Output
setopt correct

# Zle
setopt no_beep


#
# Functions
#
autoload -U compinit vcs_info zmv
compinit

setenv() { typeset -x "${1}${1:+=}${(@)argv[2,$#]}" }  # csh compatibility
freload() { while (( $# )); do; unfunction $1; autoload -U $1; shift; done }

which pgrep >/dev/null 2>&1 || \
pgrep() {
	ps axco pid,command | grep ${1} | awk '{print $1}'
}

_ssh_wrapper() {
	for pid in `pgrep ssh-agent`; do
		[[ "${pid}" == "${SSH_AGENT_PID}" ]] && \
		    ! ssh-add -l >/dev/null && ssh-add 2>/dev/null
	done
	eval "$@"
}

ssh-screen() {
	ssh=`whence -cp ssh`
	_ssh_wrapper screen -t ${(@)argv[$#]/.*/} ${ssh} "$@"
}

ssh-tmux() {
	ssh=`whence -cp ssh`
	_ssh_wrapper tmux new-window -n ${(@)argv[$#]/.*/} "'${ssh} $*'"
}

ssh-wrapper() {
	ssh=`whence -cp ssh`
	_ssh_wrapper ${ssh} "$@"
}

compdef _ssh ssh-screen=ssh ssh-tmux=ssh ssh-wrapper=ssh


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
bindkey '^I' complete-word
bindkey -M menuselect \
	'^P' up-line-or-history '^N' down-line-or-history \
	'^B' backward-char '^F' forward-char
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward


#
# Widgets
#
autoload -U select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /:@+|"
zstyle ':zle:*' word-style unspecified

autoload -U factorize-last-two-args
zle -N factorize-last-two-args
bindkey '^X^F' factorize-last-two-args


#
# Local configuration
#
[ -f ~/.zshrc_local ] && source ~/.zshrc_local


#
# Completion
#

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
