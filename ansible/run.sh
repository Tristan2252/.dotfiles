#! /bin/bash

if [ -e /usr/bin/ansible-playbook ]; then
    sudo ansible-playbook -i hosts i3laptop.yml
    ansible-playbook -i hosts basic.yml
fi
