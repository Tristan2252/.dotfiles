#!/bin/sh
CONTAINER=CSE-326
STATE=$(lxc info CSE-326 | grep -o Running)

if [ "$STATE" = "Running" ]; then 
    lxc exec CSE-326 -- sudo --login --user ubuntu -i env DISPLAY=$DISPLAY bash
    exit 0
fi

lxc start CSE-326

echo "Connecting..."
sleep 2

lxc exec CSE-326 -- sudo --login --user ubuntu -i env DISPLAY=$DISPLAY bash


exit 0
