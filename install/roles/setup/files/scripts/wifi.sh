#! /bin/bash

INTERFACE=wlp3s0
CONF=wpa_networks.conf

get_state() {
    NET_STATE=$(cat /sys/class/net/$INTERFACE/operstate)
}

set_up() {
    if [ $(pgrep wpa_supplicant) ]; then
        logger "WIFI[$$]: KILLING wpa_supplicant for ${INTERFACE}"
        killall wpa_supplicant
    fi

    logger "WIFI[$$]: initializing ${INTERFACE} connection..."
    wpa_supplicant -B -i ${INTERFACE} -c /etc/wpa_networks/${CONF}
    dhclient ${INTERFACE}
}

set_down() {
    if [ $(pgrep wpa_supplicant) ]; then
        logger "WIFI[$$]: forcibly killing wpa_supplicant for ${INTERFACE}"
        killall -9 wpa_supplicant
    fi
    
    logger "WIFI[$$]: releasing ip for ${INTERFACE}"
    dhclient -r ${INTERFACE}

    logger "WIFI[$$]: setting ${INTERFACE} DOWN"
    ip link set ${INTERFACE} down
}

get_best_net() {
    logger "WIFI[$$]: setting ${INTERFACE} UP"
    ip link set ${INTERFACE} up

    NETWORKS=($(iw dev wlp3s0 scan | egrep "signal|SSID" | sed -e "s/\tsignal: //" -e "s/\tSSID: //" | awk '{ORS = (NR % 2 == 0)? "\n" : " "; print}' | sort | awk '{print $3}' | tr '\n' ' '))

    for network in ${!NETWORKS[@]}; do
        
        # if the cs network exists, connect to it no matter the strength
        case "${NETWORKS[@]}" in  
            *"CSDeptWifi"*) 
                CONF=cs.conf
                echo "CSDeptWifi" 
                return ;; 
        esac
 
        if [ "${NETWORKS[${network}]}" = 'NMT-Encrypted' ]; then
            CONF=nmt.conf
            echo "${NETWORKS[${network}]}"
            return
        elif [ "${NETWORKS[${network}]}" = 'NMT-ENCRYPTED-WPA-WPA2' ]; then
            CONF=wpa_networks.conf
            echo "${NETWORKS[${network}]}"
        fi
    done
}

if [ "${1}" == "up" ]; then
    rfkill unblock wifi
    
    get_best_net
    logger "WIFI[$$]: using ${CONF} for ${INTERFACE}"

    set_up

elif [ "${1}" == "down" ]; then 
    set_down
    #rfkill block wifi
fi

