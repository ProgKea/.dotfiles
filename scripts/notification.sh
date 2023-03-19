#!/bin/sh

NOTIFICATION_PATH=$HOME/.local/share/notification

while getopts "st:cg" o
do
    case "${o}" in
        s)
            echo "$(head -n-1 $NOTIFICATION_PATH)\nREAD" > $NOTIFICATION_PATH
            ;;
        t)
            if pgrep -x "status_bar.sh" > /dev/null; then
                text="${OPTARG}"
                echo "$text\nUNREAD" > $NOTIFICATION_PATH
                mpv --no-terminal $HOME/.local/share/notification_sound.mp3 &
            else
                notify-send "${OPTARG}"
            fi
            ;;
        c)
            state=$(tail -n1 $NOTIFICATION_PATH)
            if [ $state = "READ" ]; then
                echo "READ"
            else
                echo "UNREAD"
            fi
            ;;
        g)
            echo "$(head -n-1 $NOTIFICATION_PATH)"
            ;;
        *) 
            exit 1
            ;;
    esac
done

if pgrep -x "status_bar.sh" > /dev/null; then
    reload_bar.sh
fi
