#! /bin/bash

HOME=/home/tristan
ALBUM=/home/tristan/Pictures/Wallpapers
RAND_PIC=$(ls $ALBUM/ | sort --random-sort | head -1)
OVERLAY=~/.dotfiles/files/overlay2.png


# covert random pic to home dir and resize for i3lock to read
convert "$ALBUM/${RAND_PIC%.*}.jpg" -resize 2560x1600! $HOME/.lockpic.png
composite -gravity center $OVERLAY $HOME/.lockpic.png $HOME/.lockpic.png
