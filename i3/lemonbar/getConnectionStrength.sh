#!/bin/bash

deviceName=$( nmcli -p device show | grep "GENERAL.DEVICE:" )
deviceName=$( echo $deviceName | cut -d ' ' -f 2 )

QualityString=$( iwconfig $deviceName | grep "Link Quality" )
QualityString=$( echo $QualityString | cut -d '=' -f 2 )
QualityString=$( echo $QualityString | cut -d ' ' -f 1 )
if [[ -z $QualityString ]]
then
	printf "%s" "%{F#ff0000} %{B#111111}"
	exit 0
fi
maxVal=$( echo $QualityString | cut -d '/' -f 2)
currentVal=$( echo $QualityString | cut -d '/' -f 1 )

strength=$( calc "floor(100/$maxVal*$currentVal)" )

if [[ $strength -gt 75 ]] 
then 
	printf "%s" "%{F#00ff00} %{B#111111}"
elif [[ $strength -gt 50 ]]
then 
	printf "%s" "%{F#b3f442} %{B#111111}"
elif [[ $strength -gt 25 ]]
then
	printf "%s" "%{F#f49d41} %{B#111111}"
else
	printf "%s" "%{F#ff0000} %{B#111111}"
fi
