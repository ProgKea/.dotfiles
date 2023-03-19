#!/bin/sh

echo "$$" > $HOME/.cache/status_barid

get_vol_raw() {
    master_vol=$(amixer get Master | tail -n1 | grep -oP "Playback \K\d+")
    master_vol_perc=$(amixer get Master | cut -d '[' -f 2 | cut -d ']' -f 1 | tail -n1)
    master_status=$(amixer get Master | cut -d '[' -f 3 | cut -d ']' -f 1 | tail -n1)

    capture_vol=$(amixer get Capture | tail -n1 | grep -oP "Playback \K\d+")
    capture_status=$(amixer get Capture | cut -d '[' -f 3 | cut -d ']' -f 1 | tail -n1)

    if [ "$master_status" = "off" ] 
    then
        master_glyph=""
    else
        master_glyph=""
    fi

    if [ "$capture_status" = "off" ] 
    then
        capture_glyph=""
    else
        capture_glyph=""
    fi

    vol_out="$(echo "[ $master_glyph: $master_vol ($master_vol_perc) ]")"
}

get_vol() {
    master_vol=$(amixer get Master | cut -d '[' -f 2 | cut -d ']' -f 1 | tail -n1)
    master_status=$(amixer get Master | cut -d '[' -f 3 | cut -d ']' -f 1 | tail -n1)

    capture_vol=$(amixer get Capture | cut -d '[' -f 2 | cut -d ']' -f 1 | tail -n1)
    capture_status=$(amixer get Capture | cut -d '[' -f 3 | cut -d ']' -f 1 | tail -n1)

    if [ "$master_status" = "off" ] 
    then
        master_glyph=""
    else
        master_glyph=""
    fi

    if [ "$capture_status" = "off" ] 
    then
        capture_glyph=""
    else
        capture_glyph=""
    fi

    vol_out="$(echo "[ $master_glyph: $master_vol  $capture_glyph ]")"
}

get_bat() {
    battery_perc=$(acpi | cut -d "," -f 2 | sed 's/ //g' | cut -d "%" -f 1)
    battery_status=$(acpi | cut -d ":" -f 2 | cut -d "," -f 1 | sed 's/ //g')
    battery_remaining=$(acpi | grep -oP "\d\d:\d\d:\d\d")

    # TODO: is there a better way to do this?
    if [ "$battery_status" = "Discharging" ]
    then 
        if [ $battery_perc -gt 0 ] && [ $battery_perc -le 25 ]
        then
            battery_glyph=""
        elif [ $battery_perc -gt 25 ] && [ $battery_perc -le 50 ]
        then 
            battery_glyph=""
        elif [ $battery_perc -gt 50 ] && [ $battery_perc -le 75 ]
        then 
            battery_glyph=""
        else
            battery_glyph=""
        fi
    else
        battery_glyph=""
    fi

    battery_out=$(echo "[ $battery_glyph $battery_perc% ]")
}

get_date() {
    date_out="[  $(date "+%a %d.%m.%y") ]"
}

get_time() {
    time_out="[  $(date "+%H:%M") ]"
}

get_all() {
    get_vol_raw
    get_bat
    get_date
    get_time
}

notify() {
    [ "$(notification.sh -c)" = "READ" ] && return 0
    xsetroot -name "$(notification.sh -g)"
    notification.sh -s
    sleep 3
}

bar() {
    notify
    get_all
    xsetroot -name "$vol_out $battery_out $date_out $time_out"
}

reload() {
    kill -SIGINT $(jobs -p) > /dev/null 2>&1
}

trap reload RTMIN

while true
do
    bar 
    sleep 5 &
    wait
done
