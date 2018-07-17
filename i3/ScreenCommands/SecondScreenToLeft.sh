#!/bin/bash
output=$(xrandr | grep "eDP1 connected")
outputDP1=$(xrandr | grep "DP1 connected")

if ! [[ -z $output ]]
then
	if ! [[ -z $outputDP1 ]]
	then
		sh ./Reset.sh
		xrandr --output DP1 --auto --scale-from 3200x1800 --output eDP1 --auto --panning 3200x1800+3200+0 --right-of DP1
	else 
		echo "ERROR DP1 not connected"
	fi
else 
	echo "ERROR eDP1 not connected"
fi
