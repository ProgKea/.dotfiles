if [ `tty` = /dev/tty1 ]; then
    export XKB_DEFAULT_LAYOUT=de
    export WLR_NO_HARDWARE_CURSORS=1
    exec sway
fi
