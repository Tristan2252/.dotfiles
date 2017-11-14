#!/bin/bash

# This script gets current value of the keyboard backlight brightness for 
# A MacBook Pro 2015, then adds or subtracts from value and resets value 
# to inc or dec brightness respectively 
#
# This script was written to work with i3 keybindings to allow for setting 
# brightness with function keys (see .i3/conf and /etc/sudoers)

CUR_VAL=$(cat /sys/class/backlight/intel_backlight/brightness)

if [ $1 = "+" ]; then
    SET_VAL=$(($CUR_VAL + 50))

    if [ $SET_VAL -le 1388 ]; then 
        for i in $(seq $CUR_VAL 8 $SET_VAL); do

            # check if value is within range of brightness levels
            echo $i | sudo tee /sys/class/backlight/intel_backlight/brightness


        done 
    fi
elif [ $1 = "-" ]; then 
    SET_VAL=$(($CUR_VAL - 50))
    
    # do nothing if value is below 0
    if [ $SET_VAL -lt 0 ]; then 
        exit 0
    fi

    for i in $(seq $CUR_VAL -8 $SET_VAL); do

        # check if value is within range of brightness levels
        echo $i | sudo tee /sys/class/backlight/intel_backlight/brightness


    done 
else
    echo "Invalid Input arg, use '+' or '-'"
fi



exit 0
