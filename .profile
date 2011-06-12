#
# dot.profile:
# 	Sh configuration
#

which keychain >/dev/null 2>&1 && eval `keychain -q --eval --timeout 10`

[ -f ~/.profile_local ] && . ~/.profile_local
