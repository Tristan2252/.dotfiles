#!/bin/bash

# Script replaces default system files with configed files located 
# in .dotfiles via symlinks

DIR=$(pwd)

MAC_LINUX_FILES=(\
                 $DIR/configs/.asoundrc \
                 $DIR/configs/compton.conf \
                 )

MAC_LINUX_LINKS=(\
                 $HOME/.asoundrc \
                 $HOME/.config/compton.conf \
                 )


for i in ${!MAC_LINUX_LINKS[@]}; do
    echo "${MAC_LINUX_FILES[$i]} -> ${MAC_LINUX_LINKS[$i]}"
done
