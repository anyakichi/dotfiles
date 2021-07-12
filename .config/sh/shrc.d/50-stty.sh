#!/bin/sh

case "$-" in
*i*)
    stty -ixon
    stty status '^T' 2>/dev/null
    ;;
esac
