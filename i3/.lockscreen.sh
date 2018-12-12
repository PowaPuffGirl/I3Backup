#!/bin/bash
rand=$(( ( RANDOM % 21 )  + 1 ))
TMPBG=/home/buttercup/Wallpapers/lockscreen$rand.png
i3lock -t -i $TMPBG
