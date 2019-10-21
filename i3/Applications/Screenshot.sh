#!/bin/bash
filename=~/Screenshots/%Y-%m-%d-%T-screenshot.png
scrot -s --exec "eom $filename" $filename
