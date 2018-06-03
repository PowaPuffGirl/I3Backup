#!/bin/bash
rand=$(( ( RANDOM % 15 )  + 1 ))
TMPBG=/home/buttercup/Wallpapers/lockscreen$rand.png
i3lock -i $TMPBG
