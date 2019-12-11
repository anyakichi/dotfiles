#!/bin/bash

# Example locker script -- demonstrates how to use the --transfer-sleep-lock
# option with i3lock's forking mode to delay sleep until the screen is locked.

## CONFIGURATION ##############################################################

# Options to pass to i3lock
i3lock_options=""

# Run before starting the locker
pre_lock() {
    #mpc pause
    return
}

# Run after the locker exits
post_lock() {
    return
}

show_software_keyboard() {
    # Hide onboard once because it can be already shown
    dbus-send --type=method_call --dest=org.onboard.Onboard \
        /org/onboard/Onboard/Keyboard org.onboard.Onboard.Keyboard.Hide

    # Wait i3lock locks the session
    sleep 2

    # Show onoard over i3lock
    dbus-send --type=method_call --dest=org.onboard.Onboard \
        /org/onboard/Onboard/Keyboard org.onboard.Onboard.Keyboard.Show
}

###############################################################################

pre_lock

# We set a trap to kill the locker if we get killed, then start the locker and
# wait for it to exit. The waiting is not that straightforward when the locker
# forks, so we use this polling only if we have a sleep lock to deal with.
if [[ -e /dev/fd/${XSS_SLEEP_LOCK_FD:--1} ]]; then
    kill_i3lock() {
        pkill -xu $EUID "$@" i3lock
    }

    trap kill_i3lock TERM INT

    # we have to make sure the locker does not inherit a copy of the lock fd
    i3lock $i3lock_options "$@" {XSS_SLEEP_LOCK_FD}<&-

    # now close our fd (only remaining copy) to indicate we're ready to sleep
    exec {XSS_SLEEP_LOCK_FD}<&-

    show_software_keyboard

    while kill_i3lock -0; do
        sleep 0.5
    done
else
    trap 'kill %%' TERM INT
    i3lock -n $i3lock_options "$@" &
    show_software_keyboard
    wait
fi

post_lock
