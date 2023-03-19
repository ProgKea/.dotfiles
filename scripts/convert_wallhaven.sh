#!/bin/bash

CMD="find ~/wallhaven -type f -name '*.jpg'"

while read -r line; do 
    convert "$line" "${line:0:-4}.png"
    echo "${line:0:-4}.png"
done <<< $(eval ${CMD})

find ~/wallhaven -type f -name "*.png"k| xargs -I% cp % ~/random_wallpapers/
