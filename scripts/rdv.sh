#!/bin/sh

clipboard_link=$(xclip -o)

if echo "${clipboard_link}" | grep -qE '^https?://'; then 
    rdrview_file=$(mktemp /tmp/rdrview.XXXX.html)
    rdrview -H ${clipboard_link} > ${rdrview_file} 
    $(cat ~/.local/share/webScripts/browser.txt) ${rdrview_file}
else 
    notification.sh -t "${clipboard_link} is not a valid link"
fi
