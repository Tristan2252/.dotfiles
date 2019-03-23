#! /bin/bash

ALBUM=/home/tristan/Pictures/Wallpapers
OVERLAYS=~/.dotfiles/files
RAND_PIC=$(ls $ALBUM/ | sort --random-sort | head -1)
RAND_OVERLAY=$(ls $OVERLAYS/*.png | sort --random-sort | head -1)


# covert random pic to home dir and resize for i3lock to read
convert "$ALBUM/${RAND_PIC%.*}.jpg" -resize 2560x1600! $HOME/.lockpic.png
composite -gravity center $RAND_OVERLAY $HOME/.lockpic.png $HOME/.lockpic.png
