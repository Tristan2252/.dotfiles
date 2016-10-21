#! /bin/bash

HOME=/home/tristan
ALBUM=/home/tristan/Pictures/Wallpapers
RAND_PIC=$(ls $ALBUM/ | grep .jpg | sort --random-sort | head -1)


# covert random pic to home dir and resize for i3lock to read
convert $ALBUM/${RAND_PIC%.*}.jpg -resize 2560x1600! $HOME/.lockpic.png
