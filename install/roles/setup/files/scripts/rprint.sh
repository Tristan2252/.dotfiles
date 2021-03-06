#!/bin/bash
# file: rprint.sh

# Enable printing remotely at school over ssh 
# by copping file over via scp and running lp
# through ssh

if [ "$1" = "list" ]; then 
    ssh -t 900318369@login.nmt.edu 'lpstat -s'
    exit 0
fi

if [ -z "$1" ] || [ -z "$2" ]; then 
    printf "Print PDF files remotely\n"
    printf "rprint [FILE].pdf [REMOTE NETWORK PRINTER]\n\n"
    printf "print double sided use -o sides=two-sided-long-edge \n"
    printf "list: show printers\n"
    exit 0
fi

EXT=$(echo $1 | awk '{ split($1, arr, "."); print arr[2] }')

if [ "$EXT" != "pdf" ]; then 
    printf "Wrong File: ext=.$EXT needs to be .pdf\n"
    exit -1
fi


scp $1 tristan@login.cs.nmt.edu:~/Print/

#ssh -t 900318369@login.nmt.edu "lp ~/Print/$1 -d $2"

ssh -t tristan@login.cs.nmt.edu "ssh 900318369@login.nmt.edu \"scp tristan@login.cs.nmt.edu:~/Print/$1 ~/Print/; lp ~/Print/$1 -d $2 $3\""
#ssh -t 900318369@login.nmt.edu "scp tristan@login.cs.nmt.edu:~/Print/$1 ~/Print/; lp ~/Print/$1 -d $2 $3"
