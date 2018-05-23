#!/bin/bash
sh ./Reset.sh

output=$(xrandr | grep "eDP1 connected")
outputDP1=$(xrandr | grep "DP1 connected")

if ! [[ -z $output ]]
then
	if ! [[ -z $outputDP1 ]]
	then
		xrandr --output VIRTUAL1 --off --output eDP1 --primary --mode 3200x1800 --pos 0x0 --rotate normal --panning 3200x1800+0+0 --scale 1x1 --output DP1 --off --output HDMI2 --off --output HDMI1 --off --output DP2 --off		
	else 
		echo "ERROR DP1 not connected"
	fi
else 
	echo "ERROR eDP1 not connected"
fi
