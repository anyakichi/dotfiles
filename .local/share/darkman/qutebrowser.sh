#!/bin/sh

if [ "$1" = dark ]; then
    qutebrowser ':config-source ~/.config/qutebrowser/oceanic-next.py'
else
    qutebrowser ':config-source ~/.config/qutebrowser/oceanic-next-light.py'
fi
