#!/bin/bash

plugins="syntastic auto-pairs nerdtree supertab ultisnips vim-snippets"

# installation dir's
PLUGIN_DIR=~/.vim/bundle

op_cmd=$1 # optional arg 1
dir=(pwd) # get current dir to cd back to after update

# optional command to update plugins
case $op_cmd in
    -u)
        for i in $plugins; do
            cd ~/.vim/bundle/$i
            git pull
        done
        cd $(dir) # cd back to working dir
        exit 0;;
esac

# Seting up plugin dir's
if [ -e ~/.vim/autoload ] && [ -e ~/.vim/bundle ]; then
    echo "Plugin folders already made"
    sleep 1
else
    echo "Seting up plugin folders"
    mkdir -p ~/.vim/autoload ~/.vim/bundle
fi

# install pathogen
if [ -e ~/.vim/autoload/pathogen.vim ]; then
    echo "Pathogen already installed"
    sleep 1
else
    echo "Installing Pathogen"
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi

cd ~/.vim/
git submodule init
git submodule update
cd - > /dev/null # dont output cd stdout

# curl -o conque.vmb https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/conque/conque_2.3.vmb

exit 0
