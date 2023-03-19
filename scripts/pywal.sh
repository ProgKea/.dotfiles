#!/bin/sh

image=$1
(wal -sti $image)
update_pywal.sh 2>/dev/null
xrdb merge $HOME/.Xresources
notification.sh -t "Wallpaper updated"
