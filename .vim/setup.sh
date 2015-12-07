#!/bin/bash

# Seting up plugin dir's
mkdir -p ~/.vim/autoload ~/.vim/bundle

# install pathogen
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# supertab "dont forget to source with 'source %' command"
git clone https://github.com/ervandew/supertab.git ~/.vim/bundle/supertab
echo ""
echo "Dont forget to source SUPERTAB with :so % command"
echo ""
sleep 2
vim ~/.vim/bundle/supertab/supertab.vim

# syntastic
git clone https://github.com/scrooloose/syntastic.git ~/.vim/bundle/syntastic

# Auto Pairs
git clone git://github.com/jiangmiao/auto-pairs.git ~/.vim/bundle/auto-pairs

# The NERD Tree
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree

exit 0
