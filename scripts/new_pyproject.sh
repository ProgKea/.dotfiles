#!/bin/sh

python -m venv env
echo "source env/bin/activate" > .tinit
echo "Tmux Init file has been created!\nYou can create a new session now."
