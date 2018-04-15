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

# dunstify is a binary built from the dunst project found here:
# https://github.com/dunst-project/dunst
# NOTE: from dunst release notes: 
#
#     Since dunstify depends on non-public parts of libnotify it may break
#     on every other libnotify version than that version that I use.
#     Because of this it does not get build and installed by default.
#     It can be build with "make dunstify". An installation target does
#     not exist.

$HOME/.dotfiles/scripts/dunstify -r 20 "    Volume: $LEVEL%"

exit 0
