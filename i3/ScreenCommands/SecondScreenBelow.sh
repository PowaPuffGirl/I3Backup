#!/bin/bash
output=$(xrandr | grep "eDP1 connected")
outputDP1=$(xrandr | grep "DP1 connected")

if ! [[ -z $output ]]
then
	if ! [[ -z $outputDP1 ]]
	then
		sh ./Reset.sh
		xrandr --output eDP1 --auto --output DP1 --auto --scale-from 3200x1800 --panning 3200x1800+0+1800 --below eDP1
	else 
		echo "ERROR DP1 not connected"
	fi
else 
	echo "ERROR eDP1 not connected"
fi
