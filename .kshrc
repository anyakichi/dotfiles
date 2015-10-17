#
# .kshrc
#

# Switch to zsh if available.
case "$-" in *i*)
    if which zsh >/dev/null 2>&1; then
        SHELL=$(which zsh)
        exec ${SHELL} -l
    fi
    ;;
esac
