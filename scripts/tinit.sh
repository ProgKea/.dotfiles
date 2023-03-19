#!/bin/sh

[ -f ./.tinit ] && tmux send-keys "$(cat ./.tinit)" || exit 0
