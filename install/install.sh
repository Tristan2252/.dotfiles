#! /bin/bash

if [ "$1" = '-h' ]; then
    echo "$ ./run [INSTALL TAG]"
    echo ""
    echo "Edit Mode: --edit"
    echo ""
    echo "Install Tags: "
    echo ""
    cat roles/setup/tasks/main.yml | grep -o -e " [a-z,1-9,_]*\.yml" -e ".*tags.*"
    exit 0
fi

if [ "$1" = '--edit' ]; then
    cd roles/setup/tasks/
    vim .
    exit 0
fi

if [ -e /usr/bin/ansible-playbook ]; then
    
    mkdir -p ~/.config

    sudo -v

    if [ -e $HOME/.ansible ]; then 
        sudo rm -r $HOME/.ansible # remove ansible config after to prvent perm conflicts
    fi

    ansible-playbook -i hosts setup.yml --tags "$1"
    exit 0
fi

echo "Install Ansible to Run with 'sudo apt install ansible'"
exit 0
