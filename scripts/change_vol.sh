#!/bin/sh

case "$1" in
    "inc") amixer -q sset Master 50+
        ;;
    "dec") amixer -q sset Master 50-
        ;;
    "mutevol") amixer set Master mute
        ;;
    "unmutevol") amixer set Master unmute
        ;;
    "mutemic") amixer set Capture nocap
        ;;
    "unmutemic") amixer set Capture cap
        ;;
esac

reload_bar.sh
