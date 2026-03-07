#!/bin/sh

qutebrower_source() {
    socket="$1"
    if [ -S "$socket" ]; then
        echo '{"args": [":config-source"], "target_arg": null, "protocol_version": 1}' | socat - UNIX-CONNECT:"$socket"
    fi
}

gsettings set org.gnome.desktop.interface color-scheme "prefer-$1"

qutebrower_source "$(find "$XDG_RUNTIME_DIR/qutebrowser" -name 'ipc-*' 2>/dev/null | head -1)"
