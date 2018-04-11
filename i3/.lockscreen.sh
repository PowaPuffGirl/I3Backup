#!/bin/bash
rand=$(( ( RANDOM % 4 )  + 1 ))
TMPBG=/home/buttercup/Wallpapers/lockscreen$rand.png
i3lock -i $TMPBG
