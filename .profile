#!/bin/sh

# .profile should only set environment variables which is statically
# defined, because reading it is skipped on wayland session.

# Share environment variables with systemd-environment.d for consistency.
for conf in ~/.config/environment.d/*.conf; do
    if [ -r "$conf" ]; then
        . "$conf"
        eval "$(sed -n '/^[A-Z]/s/^\([^=]\+\)=.*/export \1/p' "$conf")"
    fi
done
unset conf

if uwsm check may-start && uwsm select; then
  exec uwsm start default
fi
