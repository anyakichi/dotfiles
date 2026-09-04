#!/bin/sh

# Use lesspipe as an input preprocessor for less if available.
if command -v lesspipe.sh >/dev/null 2>&1; then
    LESSOPEN="|$(command -v lesspipe.sh) %s"
    export LESSOPEN
elif command -v lesspipe >/dev/null 2>&1; then
    eval "$(lesspipe)"
fi
