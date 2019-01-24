#!/bin/bash
cd /home/buttercup/Wallpapers
imageAmount=$( ls -la |wc -l)
imageAmount=$(( $imageAmount - 3 ))
rand=$(( ( RANDOM % $imageAmount ) + 1 ))
feh --bg-scale ./Wallpaper$rand.png
