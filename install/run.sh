#! /bin/bash

set -xe

sudo -v
TAGS="all"

if [ -n "$2" ]; then 
    TAGS=$2
fi

ansible-playbook $1 --tags $TAGS
