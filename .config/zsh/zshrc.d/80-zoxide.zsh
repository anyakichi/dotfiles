if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh)"
    zoxide-zi-widget() {
        __zoxide_zi
        zle reset-prompt
    }
    zle -N zoxide-zi-widget
    bindkey '^_' zoxide-zi-widget
fi
