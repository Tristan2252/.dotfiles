#! /bin/bash

if [ "$1" = "+" ]; then 
    pactl set-sink-volume 1 +2% 
else 
    if [ "$1" = "-" ]; then 
        pactl set-sink-volume 1 -2%
    else
        exit 0
    fi
fi

LEVEL=$(pactl list sinks | grep -e "^[[:space:]]Volume" | tail -1 | sed 's,.* \([0-9][0-9]*\)%.*,\1,')
notify-send "Volume" --icon=notification-audio-volume-high -h int:value:$LEVEL -h string:synchronous:volume

exit 0
