#!/bin/bash
if [[ -z $1 ]]
then 
	echo no commit message
else
	cp -R ~/.config/i3 i3 
	git add .
	git commit -m "$1"
	git push origin master
fi
