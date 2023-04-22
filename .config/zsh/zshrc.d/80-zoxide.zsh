if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh)"
    zoxide-zi-widget() {
        if [[ -n "${BUFFER}" ]]; then
            fzf-utils::file-widget
        else
            __zoxide_zi
            zle reset-prompt
        fi
    }
    zle -N zoxide-zi-widget
    bindkey '^_' zoxide-zi-widget
fi
