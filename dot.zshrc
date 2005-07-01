#	$Id$

cdpath=(~ ~/src ~/Source)
fpath=($fpath ~/.zfunc)
[ -d ~/Mail ] && mailpath=(~/Mail/**/new)

hosts=(`hostname` sopht.jp ftp.netbsd.org ftp25.nifty.com \
	www.jupiter.tj.chiba-u.jp hyper-iq.com hyper-s.jp)

# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath hosts mailpath

# Set up aliases
alias aclog='less /var/log/httpd/access_log'
alias mutt='mutt -y'
alias vi=vim

alias mv='nocorrect mv'		# no spelling correction on mv
alias cp='nocorrect cp'		# no spelling correction on cp
alias mkdir='nocorrect mkdir'	# no spelling correction on mkdir
alias make='nocorrect make'
alias j=jobs
alias pu=pushd
alias po=popd
alias d='dirs -v'
alias h=history
alias grep=egrep
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lsd='ls -ld *(-/DN)'	# List only directories and symbolic
				# links that point to directories
alias lsa='ls -ld .*'		# List only file beginning with "."

case $OSTYPE in
	darwin*)
		alias gmake=/usr/bin/make
		alias keychain='open -a "Keychain Access"'
		alias make=/usr/pkg/bin/bmake
		alias mi='open -a mi'
		alias vim=/usr/pkg/bin/vim
		;;
	netbsd*)
		;;
	solaris*)
esac

# Shell functions
setenv() { typeset -x "${1}${1:+=}${(@)argv[2,$#]}" }  # csh compatibility
freload() { while (( $# )); do; unfunction $1; autoload -U $1; shift; done }

# Autoload all shell functions from all directories in $fpath (following
# symlinks) that have the executable bit on (the executable bit is not
# necessary, but gives you an easy way to stop the autoloading of a
# particular shell function). $fpath should not be empty for this to work.
for func in $^fpath/*(N-.x:t); autoload $func

# Global aliases -- These do not have to be
# at the beginning of the command line.
alias -g G='|grep'
alias -g L='|less'
alias -g M='|more'
alias -g H='|head'
alias -g S='|sort'
alias -g T='|tail'
alias -g W='|wc'

# Set prompts
PROMPT='%m%# '    # default prompt
RPROMPT=' %~'     # prompt for right side of screen

HISTSIZE=200
DIRSTACKSIZE=20

# Watch for my friends
#watch=( $(<~/.friends) )       # watch for people in .friends file
watch=(notme)                   # watch for everybody but me
LOGCHECK=300                    # check every 5 min for login/logout activity
WATCHFMT='%n %a %l from %m at %t.'

# Set/unset  shell options
setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent noclobber
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
setopt   pushd_ignore_dups
setopt   hist_ignore_alldups
unsetopt bgnice autoparamslash

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
