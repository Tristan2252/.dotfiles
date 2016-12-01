#! /bin/bash

NET_STATE=$(cat /sys/class/net/wlp3s0/operstate)

cat /proc/acpi/button/lid/*/state | grep -q close
SUSPEND_STATE=$?


# if [ $NET_STATE == "up" ]; then
#     ifdown wlp3s0
# fi

if [ $SUSPEND_STATE -eq 0 ]; then 
    
    # if network is up, put down 
    if [ $NET_STATE = "up"  ]; then
        ifdown wlp3s0
    fi

    systemctl suspend
    exit 0
fi

if [ $NET_STATE = "down"  ]; then
    sleep 2 && ifup wlp3s0
fi

exit 0
