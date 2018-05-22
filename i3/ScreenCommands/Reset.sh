#!/bin/bash
xrandr --output VIRTUAL1 --off --output eDP1 --primary --mode 3200x1800 --pos 0x0 --rotate normal --panning 3200x1800+0+0 --scale 1x1  --output HDMI2 --off --output HDMI1 --off --output DP2 --off

xrandr --output DP1 --scale 1x1
xrandr --output DP1 --scale-from 1920x1080
xrandr --output DP1 --mode 1920x1080
xrandr --output DP1 --auto
xrandr --output DP1 --off
xrandr --output DP1-1 --scale 1x1
xrandr --output DP1-1 --scale-from 1920x1080
xrandr --output DP1-1 --mode 1920x1080
xrandr --output DP1-1 --auto
xrandr --output DP1-1 --off
xrandr --output DP1-2 --scale 1x1
xrandr --output DP1-2 --scale-from 1920x1080
xrandr --output DP1-2 --mode 1920x1080
xrandr --output DP1-2 --auto
xrandr --output DP1-2 --off

xrandr --output eDP1 --panning 3200x1800+0+0

