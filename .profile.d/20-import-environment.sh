#!/bin/sh

for conf in ~/.config/environment.d/*.conf; do
    if [ -r "$conf" ]; then
        . "$conf"
        eval "$(sed -n '/^[A-Z]/s/^\([^=]\+\)=.*/export \1/p' "$conf")"
    fi
done
unset conf
