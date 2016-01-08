#!/bin/bash

dir=~/.dotfiles
files=".vim"
powerline_dir=/usr/local/lib/python3.4/dist-packages/powerline

function linux_setup (){
	configs=$1
	if [ -e /usr/bin/i3 ]; then # check if i3 is installed
		configs="$configs .i3"
	fi

	# Check if tmux is installed as well as powerline
	# adds .bashrc because the only configuration in bashrc is for powerline
	if [ -e /usr/bin/tmux ] && [ -e $powerline_dir ]; then
		configs="$configs .tmux.conf .bashrc"
	fi

	echo $configs
}

function mac_setup (){
	configs=$1
	if [ -e /usr/local/Cellar/tmux/2.1 ] && [ -e /usr/local/lib/python2.7/site-packages ]; then
		configs="$configs .tmux.conf"
	fi

	echo "$configs .bash_profile" # allways add bash profile for ls color support on mac
}

# Github user
if [ -e /usr/bin/git ]; then
	files="$files .gitconfig"
fi


if [ $(uname -s) == "Darwin" ]; then
	files=$(mac_setup $files)
fi

if [  $(uname -s) == "Linux" ]; then
	files=$(linux_setup $files)
fi	

echo "Programs found: $files" # echo last return
sleep 1

for file in $files; do 
	if [ -h ~/$file ] #if the file is a simlink
	then
		echo "$file already setup"
	else
		if [ -e ~/$file ]; then
			echo "Removing original $file"
			rm -r ~/$file
		fi

		echo "Creating simlink for $file"
		sleep 1
		ln -s $dir/$file ~/$file
	fi
done

echo "Runing vim setup"
sleep 2
# check to see if vim is already setup
if [ -e ~/.vim/bundle ]; then
	echo "VIM already setup!"
else
	~/.vim/setup.sh
fi

exit 0
