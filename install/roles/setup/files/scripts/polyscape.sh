#! /bin/bash
HOME=/home/tristan
ALBUM=/home/tristan/Pictures/Wallpapers
RAND_PIC=$(ls $ALBUM/ | sort --random-sort | head -1)~
RAND_PIC2=$(ls $ALBUM/ | sort --random-sort | head -1)~
MASK=mask.png

if [ ! -e $MASK ]; then
    echo "Mask not found"
    exit -1
fi

convert "$ALBUM/${RAND_PIC%.*}.jpg" -resize 2560x1600! foreground.png
convert "$ALBUM/${RAND_PIC2%.*}.jpg" -resize 2560x1600! background.png
convert foreground.png $MASK -alpha off -gravity center -compose copy-opacity -composite testpic.png
composite -gravity center testpic.png background.png testpicfinal.png
