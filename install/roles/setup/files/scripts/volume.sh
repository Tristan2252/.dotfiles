#! /bin/bash
TIME_STAMP=$(awk '{print $2}' < /tmp/dunst_id)
TIME_NOW=$(date +%d%H%M%S)

notify() {
    if [ -e /tmp/dunst_id ]; then
        if [ $TIME_STAMP -lt $(($TIME_NOW-2)) ]; then
            DUNST_DI=$(dunstify -p -t 1000 "    Volume: $LEVEL%")
            echo "$DUNST_DI $TIME_NOW" > /tmp/dunst_id
        else 
            dunstify -t 1000 -r $(awk '{print $1}' < /tmp/dunst_id) "    Volume: $LEVEL%"
        fi
    else 
        DUNST_DI=$(dunstify -p -t 1000 "    Volume: $LEVEL%")
        echo "$DUNST_DI $TIME_NOW" > /tmp/dunst_id
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

LEVEL=$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $2 + 1  )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')

# dunstify is a binary built from the dunst project found here:
# https://github.com/dunst-project/dunst
# NOTE: from dunst release notes: 
#
#     Since dunstify depends on non-public parts of libnotify it may break
#     on every other libnotify version than that version that I use.
#     Because of this it does not get build and installed by default.
#     It can be build with "make dunstify". An installation target does
#     not exist.

#$HOME/.dotfiles/scripts/dunstify -r 20 "    Volume: $LEVEL%"
notify

exit 0
