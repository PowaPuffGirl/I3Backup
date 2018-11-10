#!/bin/bash
output=$(xrandr | grep "eDP1 connected")
outputDP1=$(xrandr | grep "DP1 connected")

if ! [[ -z $output ]]
then
	if ! [[ -z $outputDP1 ]]
	then
		sh ./Reset.sh	
		xrandr --output VIRTUAL1 --off --output DP1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --panning 1920x1080+0+0 --scale 1x1 --output eDP1 --off --output HDMI2 --off --output HDMI1 --off --output DP2 --off
	else 
		echo "ERROR DP1 not connected"
	fi
else 
	echo "ERROR eDP1 not connected"
fi

feh --bg-scale /home/buttercup/Wallpapers/Wallpaper2.jpg
