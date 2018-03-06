#! /bin/bash

if [ -e /usr/bin/ansible-playbook ]; then
    sudo ansible-playbook -i hosts applications.yml
    if [ -e $HOME/.ansible ]; then 
        sudo rm -r $HOME/.ansible # remove ansible config after to prvent perm conflicts
    fi

    ansible-playbook -i hosts configs.yml --tags "link,vim,lock,scripts,rc,cups,terminal,net_timeout,gesture"
    if [ -e $HOME/.ansible ]; then 
        rm -r $HOME/.ansible # remove ansible dir after just cuz i dont need it
    fi
    exit 0
fi

echo "Install Ansible to Run with 'sudo apt install ansible'"
