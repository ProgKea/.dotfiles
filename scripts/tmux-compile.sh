#!/bin/bash

directory="$(tmux display-message -p '#{pane_current_path}')"
CMD_PATH="$HOME/.local/share/tmux-compile_last_command"
change_window=false

while getopts "wc" o
do
    case "${o}" in
        c)
            set -o vi

            # TODO: do research about this and find out how it works and what it does
            IFS= read -rep "Compile command: " || { 
                exit 0
            }

            echo "$REPLY" > $CMD_PATH
            ;;
        w)
            change_window=true
            ;;
        *)
            exit 1
            ;;
    esac
done

cmd="$(cat $CMD_PATH) && notification.sh -t 'Compilation finished successfully' || notification.sh -t 'Compilation failed'"

tmux list-windows -F '#{window_name}' | grep -q "$(basename $(tmux display-message -p '#{pane_current_path}') | tr "./" "__")" && tmux-windowizer-dir "$directory"  ${cmd} || tmux-windowizer-dir "$directory" ${cmd}
[ "$change_window" = true ] && tmux select-window -t "$(basename $directory | tr "./" "__")" || exit 0
