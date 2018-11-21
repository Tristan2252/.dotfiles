#! /bin/bash

OPT=$(echo -e "\n\n\n" | rofi -dmenu -config ~/.config/rofi/powermenu.rasi)


case $OPT in
      )
        sudo systemctl start lock
        ;;
      )
        i3-msg exit
        ;;
      )
        systemctl poweroff
        ;;
      )
        systemctl reboot
        ;;
      *)
        ;;
esac


