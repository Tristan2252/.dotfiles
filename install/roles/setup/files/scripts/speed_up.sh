#!/bin/bash

# check if user is runing as root
if [ "$EUID" -ne 0 ]
    then echo "Please run as root"
    exit
fi

# excludes laguage packs from aptitude
if [ -e /etc/apt/apt.conf.d/00aptitude ]; then
    echo 'Acquire::Languages "none";' >> /etc/apt/apt.conf.d/00aptitude
    apt-get update
fi
