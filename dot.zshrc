#
# dot.zshrc:
# 	Zsh configuration
#

#
# Parameters
#

PROMPT='%m%# '
RPROMPT=' %~'

DIRSTACKSIZE=20

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

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

# Aliases for screen
if [ ! -z "${STY}" ]; then
	ssh() { screen -t ${(@)argv[$#]/.*/} ssh "$@" }
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

setenv() { typeset -x "${1}${1:+=}${(@)argv[2,$#]}" }  # csh compatibility
freload() { while (( $# )); do; unfunction $1; autoload -U $1; shift; done }


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


#
# Local configuration
#
[ -r ~/.zshrc_local ] && source ~/.zshrc_local


#
# Completion
#
compinit

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
