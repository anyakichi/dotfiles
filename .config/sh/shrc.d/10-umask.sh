#!/bin/sh

if [ "$(id -u)" = "$(id -g)" ] && [ "$(id -un)" = "$(id -gn)" ] &&
    [ "$(id -g)" = "$(stat "${HOME}" | awk '/gid/ {print $2}')" ]; then
    umask 002
else
    umask 022
fi
