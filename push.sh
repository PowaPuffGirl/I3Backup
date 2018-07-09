#!/bin/bash

message="no Message"

if ! [[ -z $1 ]]
then
	$message=$1
fi



cd ~/git/I3Backup
rm -R i3
rm -R i3blocks
rm -R terminator
rm .Xresources

cp -R ~/.config/i3 i3 
cp -R ~/.config/i3blocks i3blocks
cp -R ~/.config/terminator terminator
cp ~/.Xresources .Xresources

git add .
git commit -m "$message"
git push
