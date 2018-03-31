#! /bin/bash

if [ -e /usr/bin/ansible-playbook ]; then

    sudo -v

    if [ -e $HOME/.ansible ]; then 
        sudo rm -r $HOME/.ansible # remove ansible config after to prvent perm conflicts
    fi

    ansible-playbook -i hosts setup.yml --tags "$1"
    exit 0
fi

echo "Install Ansible to Run with 'sudo apt install ansible'"
exit 0
