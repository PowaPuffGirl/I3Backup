#!/bin/bash 
output=$(xrandr | grep "eDP1 connected")
outputDP11=$(xrandr | grep "DP1-1 connected")
outputDP12=$(xrandr | grep "DP1-2 connected")

if ! [[ -z $output ]]
then
	if ! [[ -z $outputDP11 ]]
	then
		if ! [[ -z  $outputDP12 ]]
		then
			sh ./Reset.sh			
			xrandr --output eDP1 --off --output DP1-1 --auto --scale-from 3200x1800 --output DP1-2 --auto --right-of DP1-1 --crtc 2 --panning 3200x1800+3200+0
			xrandr --output DP1-2 --scale-from 3200x1800		
		else 
			echo "ERROR DP1-2 not connected"
		fi
	else 
		echo "ERROR DP1-1 not connected"
	fi
else 
	echo "ERROR eDP1 not connected"
fi
feh --bg-scale /home/buttercup/Wallpapers/Wallpaper2.jpg
