#!/bin/bash
# file: rprint.sh

# Enable printing remotely at school over ssh 
# by copping file over via scp and running lp
# through ssh

if [ -z "$1" ] || [ -z "$2" ]; then 
    printf "Print PDF files remotely\n"
    printf "rprint [FILE].pdf [REMOTE NETWORK PRINTER]\n"
    exit 0
fi

EXT=$(echo $1 | awk '{ split($1, arr, "."); print arr[2] }')

if [ "$EXT" != "pdf" ]; then 
    printf "Wrong File: ext=.$EXT needs to be .pdf\n"
    exit -1
fi

scp $1 tvigil00@login.nmt.edu:~/Print/

ssh -t tvigil00@login.nmt.edu "lp ~/Print/$1 -d $2"
