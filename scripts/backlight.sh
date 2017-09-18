#!/bin/bash

CUR_VAL=$(cat /sys/class/leds/smc::kbd_backlight/brightness)

if [ $1 = "+" ]; then
    SET_VAL=$(($CUR_VAL + 15))
elif [ $1 = "-" ]; then 
    SET_VAL=$(($CUR_VAL - 15))
else
    echo "Invalid Input arg, use '+' or '-'"
fi

if [ $SET_VAL -lt 0 ]; then 
    exit 0
fi

if [ $SET_VAL -le 255 ]; then 
    echo $SET_VAL | sudo tee /sys/class/leds/smc::kbd_backlight/brightness
fi

exit 0
