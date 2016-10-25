#! /bin/bash
CONFIG_DIR=$(pwd)


# symlink for normal configs
link() {
    if [ ! -h $2 ]; then 
        ln -s --interactive $CONFIG_DIR/$1 $2
    else
        ln -sf $CONFIG_DIR/$1 $2
    fi
}

# symlink for sudo configs
sudo_link() {

    if [ ! -h $2 ]; then 
        sudo ln -s --interactive $CONFIG_DIR/$1 $2
    else
        sudo ln -sf $CONFIG_DIR/$1 $2
    fi
}

FILE=compton.conf
LOCATION=$HOME/.config/compton.conf
link $FILE $LOCATION

FILE=.asoundrc
LOCATION=$HOME/.asoundrc
link $FILE $LOCATION

FILE=lm_lid 
LOCATION=/etc/acpi/events/lm_lid
sudo_link $FILE $LOCATION

FILE=lid.sh 
LOCATION=/etc/acpi/lid.sh
sudo_link $FILE $LOCATION

FILE=interfaces
LOCATION=/etc/network/interfaces
sudo_link $FILE $LOCATION

FILE=rc.local
LOCATION=/etc/rc.local
sudo_link $FILE $LOCATION

FILE=lock.service
LOCATION=/etc/systemd/system/lock.service
sudo cp $FILE $LOCATION                     # systemd doesn't like symlinks

FILE=alsaapp.sh
LOCATION=/usr/local/bin/alsaapp
sudo_link $FILE $LOCATION
