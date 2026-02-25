#!/bin/sh

gsettings set org.gnome.desktop.interface color-scheme "prefer-$1"

qutebrowser ':config-source'
