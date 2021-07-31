#!/bin/sh

# If TERM is tmux-256color, terminal should support truecolor.
if [ -z "$TMUX" ] && [ "$TERM" = tmux-256color ]; then
    export COLORTERM=truecolor
fi
