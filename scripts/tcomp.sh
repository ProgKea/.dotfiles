#!/bin/sh

directory="$(tmux display-message -p '#{pane_current_path}')"
window_name=$(basename $directory | tr "./" "__")
CMD_PATH="$HOME/.local/share/tmux-compile_last_command"

while getopts "c:" o; do
    case "${o}" in 
        c)
            cmd="${OPTARG}"
            ;;
    esac
done

CMD="$(sed "${cmd}q;d" $directory/.tcomp)"
echo "$CMD" > $CMD_PATH

CMD="${CMD} && notification.sh -t 'Compilation finished successfully' || notification.sh -t 'Compilation failed'"
tmux list-windows -F '#{window_name}' | grep -q "$(basename $(tmux display-message -p '#{pane_current_path}') | tr "./" "__")" && tmux-windowizer-dir "$directory"  ${CMD} || tmux-windowizer-dir "$directory" ${CMD}
tmux select-window -t "$window_name" || exit 0
