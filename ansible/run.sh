#! /bin/bash

if [ -e /usr/bin/ansible-playbook ]; then
    sudo ansible-playbook -i hosts i3laptop.yml
    sudo rm -r $HOME/.ansible # remove ansible config after to prvent perm conflicts

    ansible-playbook -i hosts basic.yml
    rm -r $HOME/.ansible # remove ansible dir after just cuz i dont need it
    exit 0
fi

echo "Install Ansible to Run with 'sudo apt install ansible'"
