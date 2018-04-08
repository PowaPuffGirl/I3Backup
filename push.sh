#!/bin/bash
if [[ -z $1 ]]
then 
	echo no commit message
else
	cp -R ~/.config/i3 i3 
	cp -R ~/.config/i3blocks i3blocks
	cp -R ~/.config/terminator terminator
	cp ~/.Xresources .Xresources 
	git add .
	git commit -m "$1"
	git push origin master
fi
