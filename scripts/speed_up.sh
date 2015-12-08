#!/bin/bash

# excludes laguage packs from aptitude
if [ -e /etc/apt/apt.conf.d/00aptitude ]; then
	sudo echo 'Acquire::Languages "none";' >> /etc/apt/apt.conf.d/00aptitude
fi
