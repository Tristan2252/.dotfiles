#!/bin/bash
# bash powerline service settings

if [ -e /usr/local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh  ]; then
	powerline-daemon -q 
	POWERLINE_BASH_CONTINUATION=1     
	POWERLINE_BASH_SELECT=1   
	. /usr/local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh  
fi

# enable ls and terminal colors

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

alias grep='grep --color=auto'
alias cse='cd /Users/tristan/Documents/CSE/122/Notes'
alias cse-l='cd /Users/tristan/Documents/CSE/122/Labs'
alias pdflatex='/Library/TeX/texbin/pdflatex'
