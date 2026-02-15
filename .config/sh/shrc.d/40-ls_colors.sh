#!/bin/sh

if which vivid >/dev/null 2>&1; then
    LS_COLORS=$(vivid generate "$HOME/.config/vivid/oceanic-next.yml")
    export LS_COLORS
fi
