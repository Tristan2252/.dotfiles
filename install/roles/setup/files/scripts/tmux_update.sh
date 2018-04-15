#!/bin/bash

# check if user is runing as root
if [ "$EUID" -ne 0 ]
    then echo "Please run as root"
    exit
fi

sudo add-apt-repository -y ppa:pi-rho/dev
sudo apt-get update
sudo apt-get install -y tmux=2.0-1~ppa1~t

