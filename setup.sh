#!/bin/bash

dir=~/.dotfiles
files=".bashrc .vim"

if [ -e /usr/bin/i3 ]; then # check if i3 is installed
	files="$files .i3"
fi
if [ -e /usr/bin/tmux ]; then # check if tmux is installed
	files="$files .tmux.conf"
fi

echo "Programs found: $files"
sleep 1

for file in $files; do
	if [ -h ~/$file ] #if the file is a simlink
	then
		echo "$file already setup"
	else
		if [ -f ~/file ]; then
			echo "Removing original $file"
			rm -r ~/$file
		fi

		echo "Creating simlink for $file"
		sleep 1
		ln -s $dir/$file ~/$file
	fi
done
