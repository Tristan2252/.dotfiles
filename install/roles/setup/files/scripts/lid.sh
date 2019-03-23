#! /bin/bash

# This script is used in conjunction with acpi events to power down a wireless 
# interface before suspending to avoid bugs when resuming from sleep 
# (see /etc/acpi and configs/lm_lid)
INTERFACE=wlp3s0

get_state() {
    NET_STATE=$(cat /sys/class/net/$INTERFACE/operstate)
    SUSPEND_STATE=$(cat /proc/acpi/button/lid/*/state | awk '{print $2}')
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
    
    ifdown wlp3s0
    rfkill block wifi
    logger "[Lid]: SUSPENDING..."
    #systemctl suspend
fi

if [ "${SUSPEND_STATE}" = "open" ]; then
    sleep 2
    rfkill unblock wifi
fi

get_state
logger "[Lid]: STOPPED: NET_STATE ${NET_STATE} SUSPEND_STATE ${SUSPEND_STATE}"

