#
# dot.zshrc:
# 	Zsh configuration
#

cdpath=(~ ~/src ~/Documents)
fpath=(~/.zfunc $fpath)

hosts=(`hostname` sopht.jp ftp.netbsd.org)

# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath hosts mailpath

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
	alias ssh=ssh-screen
fi

# OS specific aliases
case $OSTYPE in
	darwin*)
		alias ka='open -a "Keychain Access"'
		[ -x /usr/pkg/bin/vim ] && alias vim=/usr/pkg/bin/vim
		;;
	netbsd*)
		;;
	solaris*)
esac

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


# Shell functions
setenv() { typeset -x "${1}${1:+=}${(@)argv[2,$#]}" }  # csh compatibility
freload() { while (( $# )); do; unfunction $1; autoload -U $1; shift; done }
ssh-screen() { screen -t ${(@)argv[$#]/.*/} ssh "$@" }

# Autoload all shell functions from all directories in $fpath (following
# symlinks) that have the executable bit on (the executable bit is not
# necessary, but gives you an easy way to stop the autoloading of a
# particular shell function). $fpath should not be empty for this to work.
for func in $^fpath/*(N-.x:t); autoload $func


#
# Parameters
#

PROMPT='%m%# '    # default prompt
RPROMPT=' %~'     # prompt for right side of screen

DIRSTACKSIZE=20

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000


#
# Options
#

# Changing Directories
setopt auto_cd auto_pushd cdable_vars
setopt pushd_ignore_dups pushd_minus pushd_silent pushd_to_home

# Expansion and Grobbing
setopt extended_glob

# History
setopt inc_append_history hist_ignore_alldups hist_ignore_dups
setopt hist_reduce_blanks

# Zle
setopt no_beep


# Autoload zsh modules when they are referenced
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile

# Some nice key bindings
#bindkey '^X^Z' universal-argument ' ' magic-space
#bindkey '^X^A' vi-find-prev-char-skip
#bindkey '^Xa' _expand_alias
#bindkey '^Z' accept-and-hold
#bindkey -s '\M-/' \\\\
#bindkey -s '\M-=' \|

# bindkey -v               # vi key bindings

bindkey -e                 # emacs key bindings
bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand

# Load local configuration
[ -r ~/.zshrc_local ] && source ~/.zshrc_local

# Setup new style completion system. To see examples of the old style (compctl
# based) programmable completion, check Misc/compctl-examples in the zsh
# distribution.
autoload -U compinit
compinit

# Completion Styles

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
    
# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
#zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
zstyle '*' hosts $hosts

# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro' '*?.bak'

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'

zstyle ':completion:*:cd:*' tag-order local-directories path-directories
