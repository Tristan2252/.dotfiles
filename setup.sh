#!/bin/bash

dir=~/.dotfiles
files=".vim"
powerline_dir=/usr/local/lib/python3.4/dist-packages/powerline

if [ -e /usr/bin/i3 ]; then # check if i3 is installed
	files="$files .i3"
fi

# Github user
if [ -e /usr/bin/git ]; then
	files="$files .gitconfig"
fi

# Check if tmux is installed as well as powerline
# adds .bashrc because the only configuration in bashrc is for powerline
if [ -e /usr/bin/tmux ] && [ -e $powerline_dir ]; then
	files="$files .tmux.conf .bashrc"
fi

echo "Programs found: $files"
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
if [ "$(ls -A ~/.vim/bundle/)" ]; then
	echo "VIM already setup!"
else
	~/.vim/setup.sh
fi

exit 0
