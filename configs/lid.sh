#! /bin/bash

NET_STATE=$(cat /sys/class/net/wlp3s0/operstate)

cat /proc/acpi/button/lid/*/state | grep -q close
SUSPEND_STATE=$($?)


# if [ $NET_STATE == "up" ]; then
#     ifdown wlp3s0
# fi

if [ $SUSPEND_STATE -eq 1 ]; then 
    ifdown wlp3s0
    touch /home/tristan/test
    systemctl suspend
    exit 0
fi


sleep 2 && ifup wlp3s0

exit 0
