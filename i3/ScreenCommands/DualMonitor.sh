#!/bin/bash 
sh ./Reset.sh
echo xrandr
xrandr --output eDP1 --off
xrandr --ouput VIRTUAL --off
xrandr --ouput DP1-1 --primary
xrandr --output DP1-1 --auto 
xrandr --output DP1-1 --scale-from 3200x1800 
xrandr --output DP1-2 --auto
xrandr --output DP1-2 --right-of DP1-1 --crtc 2
xrandr --output DP1-2 --scale-from 3200x1800
xrandr --output DP1-1 --panning 3200x1800+3200+0
