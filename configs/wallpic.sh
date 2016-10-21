#! /bin/bash

HOME=/home/tristan
ALBUM=/home/tristan/Pictures/Wallpapers
RAND_PIC=$(ls $ALBUM/ | grep .jpg | sort --random-sort | head -1)

# copy random wallpaper to home for feh to read at login
cp $ALBUM/$RAND_PIC $HOME/.wallpaper.jpg
