sudo -v
SRC=$(gsettings get org.gnome.desktop.background picture-uri | sed "s/file:\/\///g;s/'//g;s/%20/ /g")
set -xe

#convert shadow.png -blur 0x20 shadow.png
#composite -gravity center overlay_fg.png shadow.png overlay.png

convert "${SRC}" -blur 0x20 background.jpg
glib-compile-resources gnome-shell-theme.gresource.xml
sudo cp gnome-shell-theme.gresource /usr/share/gnome-shell/gnome-shell-theme.gresource
