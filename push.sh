#!/bin/bash
if [ -z $1 ]
then 
	echo no commit message
else 
	git add .
	git commit -m "$1"
	git push origin master
fi
