#!/bin/bash

theme_dir=/usr/share/themes

if [ -e $theme_dir/yosemite ]; then
    echo "Already Installed"
    exit 0
fi

cd $theme_dir
sudo git clone https://github.com/ewgenius/yosemite.git

cd - # cd back to script dir
exit 0
