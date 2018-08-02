#! /bin/bash

# This script is used in conjunction with acpi events to power down a wireless 
# interface before suspending to avoid bugs when resuming from sleep 
# (see /etc/acpi and configs/lm_lid)

INTERFACE=wlp3s0

NET_STATE=$(cat /sys/class/net/$INTERFACE/operstate)

cat /proc/acpi/button/lid/*/state | grep -q close
SUSPEND_STATE=$?

if [ $SUSPEND_STATE -eq 0 ]; then 
    
    # set to allow for proper suspend
    if [ "$(cat /proc/acpi/wakeup | grep XHC1 | awk '{print $3}')" = "*enabled" ]; then 
        echo XHC1 > /proc/acpi/wakeup
    fi
    if [ "$(cat /proc/acpi/wakeup | grep LID0 | awk '{print $3}')" = "*enabled" ]; then 
        echo LID0 > /proc/acpi/wakeup
    fi
    
    # if network is up, put down 
    if [ $NET_STATE = "up"  ]; then
        rfkill block wifi # block wifi
    fi

    systemctl suspend
    logger "going to sleep"
    exit 0
fi

#if [ $NET_STATE = "down"  ]; then

sleep 2
rfkill unblock wifi
ifup $INTERFACE

logger "done waking up"
exit 0
