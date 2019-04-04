#!/bin/bash
$( xrandr --output VIRTUAL1 --off --output eDP1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --panning 1920x1080+0+0 --scale 1x1  --output HDMI2 --off --output HDMI1 --off --output DP2 --off )
$( xrandr --output eDP1 --panning 1920x1080+0+0 )
cd ~/Games/factorio_alpha_x64_0.17.11/factorio/bin/x64
./factorio

sh ~/.config/i3/ScreenCommands/Reset.sh
