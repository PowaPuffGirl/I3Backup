#!/bin/bash
cd /home/buttercup/Wallpapers
imageAmount=$( ls -la |wc -l)
imageAmount=$(( $imageAmount - 3 ))
rand=$(( ( RANDOM % $imageAmount ) + 1 ))
i3lock -B=0.1 

