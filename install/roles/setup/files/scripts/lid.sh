#! /bin/bash

# This script is used in conjunction with acpi events to power down a wireless 
# interface before suspending to avoid bugs when resuming from sleep 
# (see /etc/acpi and configs/lm_lid)

INTERFACE=wlp3s0
NET_STATE=$(cat /sys/class/net/$INTERFACE/operstate)
SUSPEND_STATE=$(cat /proc/acpi/button/lid/*/state | awk '{print $2}')

logger "[Lid]: STARTED: NET_STATE ${NET_STATE} SUSPEND_STATE ${SUSPEND_STATE}"

get_best_net() {
    if [ "${NET_STATE}" = "down"  ]; then
        ip link set wlp3s0 up
        sleep 2
    fi

    NETWORKS=($(iwlist ${INTERFACE} scan | grep -e "ESSID" -e "Quality" | sed 's/.*Quality=//g; s/Signal.*//g; s/.*ESSID://g'))

     for network in ${!NETWORKS[@]}; do
        if [ "${NETWORKS[${network}]}" = '"CSDeptWifi"' ]; then
            INTERFACE="$INTERFACE=cs"
            return
        elif [ "${NETWORKS[${network}]}" = '"NMT-Encrypted"' ]; then
            INTERFACE="$INTERFACE=nmt"
            return
        fi
     done
}

if [ "${SUSPEND_STATE}" = "closed" ]; then 
    
    # set to allow for proper suspend
    if [ "$(cat /proc/acpi/wakeup | grep XHC1 | awk '{print $3}')" = "*enabled" ]; then 
        echo XHC1 > /proc/acpi/wakeup
        logger "[Lid]: XHC1 DISABLED"
    fi
    if [ "$(cat /proc/acpi/wakeup | grep LID0 | awk '{print $3}')" = "*enabled" ]; then 
        echo LID0 > /proc/acpi/wakeup
        logger "[Lid]: LID0 DISABLED"
    fi
    
    # if network is up, put down 
    if [ "${NET_STATE}" = "up"  ]; then
        logger "[Lid]: SETTING ${INTERFACE} => DOWN"
        ifdown ${INTERFACE}
        rfkill block wifi
    fi

    logger "[Lid]: SUSPENDING..."
    systemctl suspend
fi

if [ "${SUSPEND_STATE}" = "open" ]; then
    sleep 2
    
    rfkill unblock wifi
    
    if [ $(pgrep dhclient) ]; then
        logger "[Lid]: KILLING dhclient for ${INTERFACE}"
        killall -9 dhclient
    fi
    if [ $(pgrep wpa_supplicant) ]; then
        logger "[Lid]: KILLING wpa_supplicant for ${INTERFACE}"
        killall -9 dhclient
        ifdown ${INTERFACE}
    fi

    get_best_net

    logger "[Lid]: SETTING ${INTERFACE} => UP"
    ifup $INTERFACE
fi

logger "[Lid]: STOPPED: NET_STATE ${NET_STATE} SUSPEND_STATE ${SUSPEND_STATE}"

exit 0
