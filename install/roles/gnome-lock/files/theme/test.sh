#! /bin/bash
sudo -v
SRC=$(gsettings get org.gnome.desktop.background picture-uri | sed "s/file:\/\///g;s/'//g;s/%20/ /g")
set -xe


convert -size 410x310 xc:transparent -fill "rgba(0,0,0,0.4)"  -draw "roundrectangle 0,0 410,310 18,18" tmp.png
convert tmp.png -background none -gravity center -extent 450x350 -blur 0x9 shadow.png
convert -size 400x300 xc:transparent -fill "rgba(243,243,243,1.0)" -draw "roundrectangle 0,0 400,300 5,5" overlay_fg.png
composite -gravity center overlay_fg.png shadow.png overlay.png

convert "${SRC}" -blur 0x20 background.jpg
glib-compile-resources gnome-shell-theme.gresource.xml
sudo cp gnome-shell-theme.gresource /usr/share/gnome-shell/gnome-shell-theme.gresource

