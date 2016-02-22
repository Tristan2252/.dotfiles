#!/bin/bash

plugins="syntastic auto-pairs nerdtree supertab latex-plugins"

# installation dir's
PLUGIN_DIR=~/.vim/bundle
syntastic=~/.vim/bundle/syntastic
auto_pairs=~/.vim/bundle/auto-pairs
nerdtree=~/.vim/bundle/nerdtree
supertab=~/.vim/bundle/supertab

op_cmd=$1 # optional arg 1
dir=(pwd) # get current dir to cd back to after update

# optional command to update plugins
if [ "-u" = "$op_cmd" ]; then
    for i in $plugins; do
        cd ~/.vim/bundle/$i
        git pull
    done
    cd $(dir) # cd back to working dir
    exit 0
fi

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

# install all plugins
for i in $plugins; do
    if [ "$(ls -A ~/.vim/bundle/$i/)" ]; then
        echo "$i is already installed"  
        sleep 1
    else
        case $i in
            supertab)
                git clone https://github.com/ervandew/supertab.git $supertab
                echo ""
                echo "Source SUPERTAB with :so % command"
                echo ""
                sleep 2
                vim $supertab/plugin/supertab.vim;;
            auto-pairs)
                git clone git://github.com/jiangmiao/auto-pairs.git $auto_pairs;;
            nerdtree)
                git clone https://github.com/scrooloose/nerdtree.git $nerdtree;;
            syntastic)
                git clone https://github.com/scrooloose/syntastic.git $syntastic;;
            latex-plugins)
                git clone https://github.com/tomtom/tlib_vim.git $PLUGIN_DIR/tlib_vim
                git clone https://github.com/MarcWeber/vim-addon-mw-utils.git $PLUGIN_DIR/vim-addon-mw-utils
                git clone https://github.com/garbas/vim-snipmate.git $PLUGIN_DIR/vim-snipmate
                git clone https://github.com/honza/vim-snippets.git $PLUGIN_DIR/vim-snippets;;
        esac
    fi
done

exit 0
