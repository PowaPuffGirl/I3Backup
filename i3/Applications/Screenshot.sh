#!/bin/bash
filename=~/Screenshots/%Y-%m-%d-%T-screenshot.png
scrot -s --exec "gimp $filename" $filename
