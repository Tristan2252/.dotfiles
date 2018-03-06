#!/bin/sh
CONTAINER=CSE-326
STATE=$(lxc info $CONTAINER | grep -o Running)

if [ "$STATE" = "Running" ]; then 
    lxc exec $CONTAINER -- sudo --login --user ubuntu -i env DISPLAY=$DISPLAY bash
    exit 0
fi

lxc start $CONTAINER

echo "Connecting..."
sleep 2

lxc exec $CONTAINER -- sudo --login --user ubuntu -i env DISPLAY=$DISPLAY bash


exit 0
