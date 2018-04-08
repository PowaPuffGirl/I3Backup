#!/bin/bash
backgroundColor=$1
activeTextColor=$2
currentActiveColor=$3
inactiveTextColor=$4
borderColor=$5
separatorColor=$borderColor
if [[ ! -z $6 ]] 
then 
	params=$6	
else 
	params=""
fi
rofi -show \
	-dmenu \
	$params \
	-p "Application / non sudo Command / calc" \
	-i \
	-location 3 \
	-width 25 \
	-font "notosans 18" \
	-columns 1 \
	-bw 4 \
	-kb-row-select "Tab" \
	-kb-row-tab "" \
	-color-window "$backgroundColor, $borderColor, $separatorColor" \
	-color-normal "$backgroundColor, $inactiveTextColor, $backgroundColor,  $currentActiveColor,	$activeTextColor" 
	#	-color-active "$backgroundColor, $textColor, $backgroundColor, #007763, #b1b4b3" \
	#	-color-urgent "$backgroundColor, $textColor, $backgroundColor, #77003d, #b1b4b3" \
#	-modi run \
