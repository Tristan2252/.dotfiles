#! /bin/bash
# file: new_mac.sh
#
# this file is used to change the mac address 
# of an interface and reconnect. This is useful
# when techs network sucks...

if [ ! $1 ]; then 
    printf "new_mac [ INTERFACE ]\n"
    exit 0
fi

NEW_MAC=$(hexdump -n 8 -e '4/4 "%0X"' /dev/random | sed 's/.\{2\}/&:/g' | cut -c 1-17)

sudo ip link set dev $1 down
sudo ip link set dev $1 address $NEW_MAC

#sudo dhclient -r $1
#sudo ip link set dev $1 up

#sudo dhclient $1

exit 0
