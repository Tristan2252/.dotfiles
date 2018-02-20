#! /bin/bash

STATE=$(lxc info CSE-326 | grep -o Running)

if [ "$STATE" = "Running" ]; then 
    ssh ubuntu@10.0.4.157 -X
    exit 0
fi

lxc start CSE-326

echo "Connecting..."
sleep 2

ssh ubuntu@10.0.4.157 -XC

exit 0
