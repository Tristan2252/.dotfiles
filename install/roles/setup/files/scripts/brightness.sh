#!/bin/bash
# Use this script to adjust the brightness level of intel backlight.
# The percentage is then calculated and reported to dunst

MAX=24242
OFFSET=1212
CUR_VAL=$(< /sys/class/backlight/intel_backlight/brightness)

notify() {
    # convert number to percent
    VALUE=$(echo "scale = 2; (($CUR_VAL / $MAX) * 100)" | bc)

    if [ -e /tmp/dunst_id ]; then
        DUNST_ID=$(dunstify -p -t 1000 -r $(< /tmp/dunst_id) "    Brightness: $VALUE%")
    else 
        DUNST_ID=$(dunstify -p -t 1000 "    Brightness: $VALUE%")
    fi
    
    echo "$DUNST_ID" > /tmp/dunst_id
}

if [ $(pgrep $0) ]; then
    exit 0

elif [ $1 = "+" ]; then
    SET_VAL=$(($CUR_VAL + $OFFSET))

    if [ $SET_VAL -le $MAX ]; then
        #notify
        echo $SET_VAL | sudo tee /sys/class/backlight/intel_backlight/brightness # be sure to add command to sudo file
    fi

elif [ $1 = "-" ]; then 
    SET_VAL=$(($CUR_VAL - $OFFSET))
    
    # do nothing if value is below 0
    if [ $SET_VAL -ge 0 ]; then 
        #notify
        echo $SET_VAL | sudo tee /sys/class/backlight/intel_backlight/brightness # be sure to add command to sudo file
    fi

elif [ "$1" = "cal" ]; then 
    echo 0 | sudo tee /sys/class/backlight/intel_backlight/brightness
    
    CUR_VAL=$(cat /sys/class/backlight/intel_backlight/brightness)
    SET_VAL=$(($CUR_VAL + 680))

    if [ $SET_VAL -le $MAX ]; then

        for i in $(seq $CUR_VAL 5 $SET_VAL); do
            echo $i | sudo tee /sys/class/backlight/intel_backlight/brightness
        done 
    fi
else
    echo "Invalid Input arg, use '+' or '-' or 'cal' "

fi

