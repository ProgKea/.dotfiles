#!/bin/sh

stow -d home -t $HOME .
stow -d config -t $HOME/.config .
