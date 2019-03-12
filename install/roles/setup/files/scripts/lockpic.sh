#! /bin/bash

SCREEN_SIZE=1366x768
ALBUM=/home/tristan/Pictures/Wallpapers
OVERLAYS=/home/tristan/.dotfiles/files
RAND_PIC=$(ls $ALBUM/ | sort --random-sort | head -1)
RAND_OVERLAY=$(ls $OVERLAYS/*.png | sort --random-sort | head -1)


# covert random pic to home dir and resize for i3lock to read
convert "$ALBUM/${RAND_PIC%.*}.jpg" -resize $SCREEN_SIZE! /home/tristan/.lockpic.png
#composite -gravity center $RAND_OVERLAY /home/tristan/.lockpic.png /home/tristan/.lockpic.png
