#!/bin/sh

if which vivid >/dev/null 2>&1; then
    LS_COLORS=$(vivid generate "$HOME/.config/vivid/oceanic-next.yml")
    export LS_COLORS
elif which dircolors >/dev/null 2>&1 && [ -f "${HOME}/.dircolors" ]; then
    eval "$(dircolors -b "${HOME}/.dircolors")"
fi
