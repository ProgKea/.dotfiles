#!/bin/bash

get_config() {
    start_wal=$(grep -n "PYWAL START" $config | cut -d: -f1)
    end_wal=$(grep -n "PYWAL END" $config | cut -d: -f1)

    top_config=$(head -n${start_wal} $config)
    bot_config=$(tail -n+${end_wal} $config)

    [ -z "$top_config" ] && exit 1
}

case "$1" in
    "dmenu")
        config="$HOME/.ansible_dotfiles_installer/programs/suckless/dmenu/config.h"
        wal_colors="$HOME/.cache/wal/colors-wal-dmenu.h"
        compile_command="(cd $HOME/.ansible_dotfiles_installer/programs/suckless/dmenu; sudo make install)"
        ;;
    "tmux")
        config="$HOME/.tmux.conf"
        wal_colors="$HOME/.cache/wal/colors"
        bg=$(sed -n '11p' $wal_colors)
        fg=$(sed -n '1p' $wal_colors)
        wal_colors="set-option -g status-style 'bg=$bg fg=$fg'"
        get_config
        echo -e "$top_config\n$wal_colors\n$bot_config" > $config
        tmux source-file $HOME/.tmux.conf
        exit 0
        ;;
    "dwm")
        config="$HOME/.Xresources"
        wal_colors="$HOME/.cache/wal/colors"
        compile_command="xrdb $config && xdotool key alt+F12"

        colors=""
        colors="${colors}dwm.normbordercolor: $(sed '1q;d' $wal_colors)\n"
        colors="${colors}dwm.normbgcolor: $(sed '1q;d' $wal_colors)\n"
        colors="${colors}dwm.normfgcolor: $(sed '8q;d' $wal_colors)\n"
        colors="${colors}dwm.selbordercolor: $(sed '8q;d' $wal_colors)\n"
        colors="${colors}dwm.selbgcolor: $(sed '3q;d' $wal_colors)\n"
        colors="${colors}dwm.selfgcolor: $(sed '1q;d' $wal_colors)"

        get_config
        echo -e "$top_config\n$colors\n$bot_config" > $config
        echo -e $compile_command | sh
        exit 0
        ;;
    "xresources")
        config="$HOME/.Xresources"
        wal_colors="$HOME/.cache/wal/colors"
        compile_command="xrdb $config && xdotool key alt+F12"

        colors=""
        colors="${colors}dwm.normbordercolor: $(sed '1q;d' $wal_colors)\n"
        colors="${colors}dwm.normbgcolor: $(sed '1q;d' $wal_colors)\n"
        colors="${colors}dwm.normfgcolor: $(sed '8q;d' $wal_colors)\n"
        colors="${colors}dwm.selbordercolor: $(sed '8q;d' $wal_colors)\n"
        colors="${colors}dwm.selbgcolor: $(sed '3q;d' $wal_colors)\n"
        colors="${colors}dwm.selfgcolor: $(sed '1q;d' $wal_colors)\n"
        colors="${colors}$(cat ~/.cache/wal/colors.Xresources)"

        get_config
        echo -e "$top_config\n$colors\n$bot_config" > $config
        echo -e $compile_command | sh
        exit 0
        ;;
    *)
        update_pywal.sh dmenu
        update_pywal.sh tmux
        update_pywal.sh dwm
        exit 0
        ;;
esac

get_config
wal_colors=$(grep -v "SchemeUrg" $wal_colors | sed 's/sel_fg,/norm_bg,/')

echo -e "$top_config\n$wal_colors\n$bot_config" > $config
echo -e $compile_command | sh
