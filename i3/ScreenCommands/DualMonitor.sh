#!/bin/bash 
xrandr --output eDP1 --off --output DP1-1 --auto --scale-from 3200x1800 --output DP1-2 --auto --right-of DP1-1 --crtc 2 --panning 3200x1800+3200+0
xrandr --output DP1-2 --scale-from 3200x1800
