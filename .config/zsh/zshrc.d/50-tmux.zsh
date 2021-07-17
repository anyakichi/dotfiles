preexec_tmux()
{
    eval "$(tmux show-environment -s)"
}

if [[ -n "${TMUX}" ]]; then
    add-zsh-hook preexec preexec_tmux
fi
