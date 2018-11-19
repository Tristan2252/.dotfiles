#! /bin/bash
# Use this script to adjust volume level via pulse audio 
# pactl utility. The level is then reported to dunst

notify() {
    LEVEL=$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $2 + 1  )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')

    if [ -e /tmp/dunst_id ]; then
        DUNST_ID=$(dunstify -p -t 1000 -r $(< /tmp/dunst_id) "    Volume: $LEVEL%")
        echo "$DUNST_ID" > /tmp/dunst_id
    else 
        DUNST_DI=$(dunstify -p -t 1000 "    Volume: $LEVEL%")
        echo "$DUNST_ID" > /tmp/dunst_id
    fi
}

if [ "$1" = "-h" ] || [ -z "$1" ] || [ -z "$2" ]; then 
    printf "volume [+|-] [SINKNUM]\n"
    exit -1
fi

if [ "$1" = "+" ]; then 
    pactl set-sink-volume $2 +2% 
else 
    if [ "$1" = "-" ]; then 
        pactl set-sink-volume $2 -2%
    else
        exit 0
    fi
fi

notify

exit 0
