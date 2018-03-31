#!/bin/bash

# This script gets current value of the keyboard backlight brightness for 
# A MacBook Pro 2015, then adds or subtracts from value and resets value 
# to inc or dec brightness respectively 
#
# This script was written to work with i3 keybindings to allow for setting 
# brightness with function keys (see .i3/conf and /etc/sudoers)

CUR_VAL=$(cat /sys/class/leds/smc::kbd_backlight/brightness)

if [ $1 = "+" ]; then
    SET_VAL=$(($CUR_VAL + 15))
elif [ $1 = "-" ]; then 
    SET_VAL=$(($CUR_VAL - 15))
else
    echo "Invalid Input arg, use '+' or '-'"
fi

# do nothing if value is below 0
if [ $SET_VAL -lt 0 ]; then 
    exit 0
fi

# check if value is within range of brightness levels
if [ $SET_VAL -le 255 ]; then 
    echo $SET_VAL | sudo tee /sys/class/leds/smc::kbd_backlight/brightness
fi

exit 0
