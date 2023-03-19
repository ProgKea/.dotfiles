#!/bin/sh
random_bg=$(find ~/random_wallpapers -type f | shuf -n1)
swaymsg "output * bg $random_bg fill"
