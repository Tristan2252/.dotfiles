#!/bin/bash

setup ()
{   if [ -e ~/$config ]; then # if file exists and is not a link
        if [ ! -L ~/$config ]; then 
            rm -r ~/$config
            ln -s ~/.dotfiles/$config ~/$config
        fi

    elif [ ! -e ~/$config ]; then
        ln -s ~/.dotfiles/$config ~/$config
    fi
}

linux_setup(){
    
    # i3 dotfile 
    if [ -e /usr/bin/i3 ]; then
        config=".i3"
        setup
        printf "i3 setup..\n"
    fi
    
    # tmux config 
    if [ -e /usr/bin/tmux ]; then
        config=".tmux.conf"
        setup
        printf "tmux setup..\n"
    fi

    # Vim config
    if [ -e /usr/bin/vim ]; then
        config=".vim"
        setup
        printf "Initializing vim..\n"

        # Initialize vim by pulling plugins from git
        ~/.vim/setup.sh
        printf "vim setup..\n"
    fi

    # git user settings
    if [ -e /usr/bin/git ]; then
        config=".gitconfig"
        setup
        printf "git setup..\n"
    fi

    # powerline config file setup
    if [ -e /usr/local/lib/python3.4/dist-packages/powerline ]; then
        printf "setting up powerline..\n"
        powerline_config
        printf "powerline setup..\n"
    fi

    if [ -e /usr/local/lib/python2.7/dist-packages/powerline ]; then
        printf "setting up powerline..\n"
        powerline_config
        printf "powerline setup..\n"
    fi

    if [ -e /usr/bin/gdb ]; then 
        ln -s ~/.dotfiles/gdbinit/gdbinit ~/.gdbinit
        printf "gdb setup..\n"
    fi

    config=".bashrc"
    setup
    printf "bash setup..\n"
}

mac_setup(){
    
    # tmux config 
    if [ -e /usr/local/bin/tmux ]; then
        config=".tmux.conf"
        setup
        printf "tmux setup..\n"
    fi

    # Vim config
    if [ -e /usr/local/bin/vim ]; then
        config=".vim"
        setup
        printf "Initializing vim..\n"

        # Initialize vim by pulling plugins from git
        ~/.vim/setup.sh
        printf "vim setup..\n"
    fi

    # git user settings
    if [ -e /usr/local/bin/git ]; then
        config=".gitconfig"
        setup
        printf "git setup..\n"
    fi

    # on mac the only setting in bashrc is powerline
    if [ -e /usr/local/lib/python2.7/site-packages/powerline ]; then
        config=".bash_profile"
        setup 
        rm -r ~/.bashrc; ln -s ~/.dotfiles/.bashrc.mac ~/.bashrc
        printf "bash setup..\n"
        printf "setting up powerline..\n"
        powerline_config
        printf "powerline setup..\n"
    fi
}

powerline_config ()
{
    if [ -e ~/.config/powerline ]; then
        rm -r ~/.config/powerline
    fi

    ln -s ~/.dotfiles/powerline ~/.config
}

# test os running 
if [ $(uname -s) == "Darwin" ]; then
    mac_setup $files
fi

if [  $(uname -s) == "Linux" ]; then
    linux_setup $files
fi  

