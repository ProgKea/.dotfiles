#!/bin/sh

nix-shell --run '
stow -d home -t $HOME .
stow -d config -t $HOME/.config .
sudo stow -d nixos -t /etc/nixos .
'
