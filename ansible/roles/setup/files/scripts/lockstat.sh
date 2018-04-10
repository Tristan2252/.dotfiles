#! /bin/bash

i3lock -i /home/tristan/.lockpic.png -c '#000000' -o '#191d0f' -w '#572020' -l '#ffffff' -e
#i3lock -c '#000000' -o '#191d0f' -w '#572020' -l '#ffffff' -e

#sleep 1

LOCK_WIN_ID=$(xwininfo -name 'i3lock' | grep -oE 'id: 0x[a-z0-9]+' | cut -b 5-)

if [ -z "$LOCK_WIN_ID" ]; then 
    exit 0
fi

#conky -q --window-id=$WIN_ID -c /home/tristan/.dotfiles/configs/conky_widget  &
conky -q --window-id=$WIN_ID -c /home/tristan/.dotfiles/configs/conky_widget_bar  &
#conky -q --window-id=$WIN_ID -c /home/tristan/.dotfiles/configs/conky_widget_bar_right  &
#conky -q --window-id=$WIN_ID -c /home/tristan/.dotfiles/configs/conky_widget_left_middle &

exit 0
