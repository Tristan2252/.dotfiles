#! /bin/bash

# This script is used in conjunction with acpi events to power down a wireless 
# interface before suspending to avoid bugs when resuming from sleep 
# (see /etc/acpi and configs/lm_lid)

INTERFACE=wlp3s0

NET_STATE=$(cat /sys/class/net/$INTERFACE/operstate)

cat /proc/acpi/button/lid/*/state | grep -q close
SUSPEND_STATE=$?


if [ $SUSPEND_STATE -eq 0 ]; then 
    
    # if network is up, put down 
    if [ $NET_STATE = "up"  ]; then
        ifdown $INTERFACE
        ifdown school # if school is up take it down to avoid bugs
        rfkill block wifi # block wifi
    fi

    systemctl suspend
fi

if [ $NET_STATE = "down"  ]; then
    sleep 2
    rfkill unblock wifi
    ifup $INTERFACE

fi

exit 0
