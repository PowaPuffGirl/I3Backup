#!/bin/bash
backgroundColor=$1
activeTextColor=$2
currentActiveColor=$3
inactiveTextColor=$4
rofi -show \
	-dmenu \
	-p "Application / non sudo Command / calc" \
	-i \
	-location 1 \
	-width 100 \
	-lines 1\
	-separator-style none \
	-font "notosans 18" \
	-columns 10 \
	-bw 0 \
	-hide-scrollbar \
	-kb-row-select "Tab" \
	-kb-row-tab "" \
	-color-window "$backgroundColor" \
	-color-normal "$backgroundColor, $inactiveTextColor, $backgroundColor, $currentActiveColor, 		$activeTextColor" \
	#	-color-active "$backgroundColor, $textColor, $backgroundColor, #007763, #b1b4b3" \
	#	-color-urgent "$backgroundColor, $textColor, $backgroundColor, #77003d, #b1b4b3" \
	#	-modi run \
