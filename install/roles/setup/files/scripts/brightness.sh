#!/bin/bash

MAX=1370
CUR_VAL=$(cat /sys/class/backlight/intel_backlight/brightness)
IS_RUNNING=$(pidof -x "brightness.sh" | wc -w)
TIME_STAMP=$(awk '{print $2}' < /tmp/dunst_id)
TIME_NOW=$(date +%d%H%M%S)

notify() {
    if [ -e /tmp/dunst_id ]; then
        if [ $TIME_STAMP -lt $(($TIME_NOW-2)) ]; then
            DUNST_DI=$(dunstify -p -t 1000 "    Brightness: $VALUE%")
            echo "$DUNST_DI $TIME_NOW" > /tmp/dunst_id
        else 
            dunstify -t 1000 -r $(awk '{print $1}' < /tmp/dunst_id) "    Brightness: $VALUE%"
        fi
    else 
        DUNST_DI=$(dunstify -p -t 1000 "    Brightness: $VALUE%")
        echo "$DUNST_DI $TIME_NOW" > /tmp/dunst_id
    fi
}

if [ $IS_RUNNING -ge 3 ]; then
    exit 0
fi

if [ $1 = "+" ]; then
    SET_VAL=$(($CUR_VAL + 10))

    if [ $SET_VAL -le $MAX ]; then

        VALUE=$(echo "scale = 2; (($CUR_VAL / $MAX) * 100)" | bc)
        notify

        for i in $(seq $CUR_VAL 2 $SET_VAL); do
            echo $i | sudo tee /sys/class/backlight/intel_backlight/brightness # be sure to add command to sudo file
        done 
    fi
elif [ $1 = "-" ]; then 
    SET_VAL=$(($CUR_VAL - 10))
    
    # do nothing if value is below 0
    if [ $SET_VAL -lt 0 ]; then 
        exit 0
    fi

    VALUE=$(echo "scale = 2; (($CUR_VAL / $MAX) * 100)" | bc)
    #$HOME/.dotfiles/scripts/dunstify -r 2000 "   Brightness: $VALUE%"
    notify

    for i in $(seq $CUR_VAL -2 $SET_VAL); do
        # check if value is within range of brightness levels
        echo $i | sudo tee /sys/class/backlight/intel_backlight/brightness
    done 
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

