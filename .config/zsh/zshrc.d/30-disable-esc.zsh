zle-nop() { }
zle -N nop zle-nop
bindkey '^[' nop
KEYTIMEOUT=1
