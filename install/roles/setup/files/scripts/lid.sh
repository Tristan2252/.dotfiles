#! /bin/bash

# This script is used in conjunction with acpi events to power down a wireless 
# interface before suspending to avoid bugs when resuming from sleep 
# (see /etc/acpi and configs/lm_lid)

INTERFACE=wlp3s0

get_state() {
    NET_STATE=$(cat /sys/class/net/$INTERFACE/operstate)
    SUSPEND_STATE=$(cat /proc/acpi/button/lid/*/state | awk '{print $2}')
}

get_best_net() {
    get_state
    if [ "${NET_STATE}" = "down"  ]; then
        ip link set ${INTERFACE} up
        sleep 2
    fi

    #NETWORKS=($(iwlist ${INTERFACE} scan | grep -e "ESSID" -e "Quality" | sed 's/.*Quality=//g; s/Signal.*//g; s/.*ESSID://g'))
    NETWORKS=($(sudo iw dev wlp3s0 scan | egrep "signal|SSID" | sed -e "s/\tsignal: //" -e "s/\tSSID: //" | awk '{ORS = (NR % 2 == 0)? "\n" : " "; print}' | sort | awk '{print $3}' | tr '\n' ' '))

    for network in ${!NETWORKS[@]}; do
       if [ "${NETWORKS[${network}]}" = 'CSDeptWifi' ]; then
           INTERFACE="$INTERFACE=cs"
           return
       elif [ "${NETWORKS[${network}]}" = 'NMT-Encrypted' ]; then
           INTERFACE="$INTERFACE=nmt"
           return
       elif [ "${NETWORKS[${network}]}" = 'NMT-ENCRYPTED-WPA-WPA2' ]; then
           return
       fi
    done
}

get_state
logger "[Lid]: STARTED: NET_STATE ${NET_STATE} SUSPEND_STATE ${SUSPEND_STATE}"

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
    get_state
    if [ "${NET_STATE}" = "up"  ]; then
        logger "[Lid]: SETTING ${INTERFACE} => DOWN"
        ip link set ${INTERFACE} down
        sleep 2 # wait for network to go down
        rfkill block wifi
    fi

    logger "[Lid]: SUSPENDING..."
    #systemctl suspend
fi

if [ "${SUSPEND_STATE}" = "open" ]; then
    sleep 2
    
    rfkill unblock wifi

    # stop interface from starting on resume
    ip link set ${INTERFACE} down 

    if [ $(pgrep dhclient) ]; then
        logger "[Lid]: KILLING dhclient for ${INTERFACE}"
        killall -9 dhclient
    fi
    if [ $(pgrep wpa_supplicant) ]; then
        logger "[Lid]: KILLING wpa_supplicant for ${INTERFACE}"
        killall -9 wpa_supplicant
        ifdown ${INTERFACE}
    fi

    get_best_net

    logger "[Lid]: SETTING ${INTERFACE} => UP"
    ifup $INTERFACE
fi

get_state
logger "[Lid]: STOPPED: NET_STATE ${NET_STATE} SUSPEND_STATE ${SUSPEND_STATE}"

