#!/bin/sh

usage() { echo "Usage: $0 [-s <string>]" 1>&2; exit 1; }

while getopts ":s:" o; do
    case "${o}" in
        s)
            query=$(echo "${OPTARG}" | tr ' ' '+')
            path="$HOME/wallhaven/$query"
            ;;
        *)
            usage
            ;;
    esac
done

[ -z "$query" ] && query=$(:|dmenu -p "Query:")
[ -z "$query" ] && exit 1

mkdir $path > /dev/null 2>&1
cd $path || exit 1
page=1 
while [ $page -lt 100 ] 
do 
    [ -z $(curl -s "https://wallhaven.cc/api/v1/search?q=$query&page=$page" | jq '.data[].path' | xargs -r wget) ] && break
    page=$(( page+1 ))
done

notification.sh -t "Finished downloading wallpapers"
