#!/bin/bash

message="no Message"

if ! [[ -z $1 ]]
then
	$message=$1
fi



cd /home/buttercup/git/I3Backup
rm -R i3
rm -R i3blocks
rm -R terminator
rm .Xresources

cp -R /home/buttercup/.config/i3 i3 
cp -R /home/buttercup/.config/i3blocks i3blocks
cp -R /home/buttercup/.config/terminator terminator
cp /home/buttercup/.Xresources .Xresources

git add .
git commit -m "$message"
git push
