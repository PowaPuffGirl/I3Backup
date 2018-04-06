#!/bin/bash
backgroundColor=$1
activeTextColor=$2
currentActiveColor=$3
inactiveTextColor=$4
thisPath=~/.config/i3
scriptsFolder=$thisPath/Applications
errorPrompt="application not found OR no mathematical expression OR calc is not installed OR command not found (sudo calls not possible)"

selected=$(cat $thisPath/ApplicationsToLaunch.txt| grep . | sort | sh $thisPath/.startThemedRofi.sh $backgroundColor $activeTextColor $currentActiveColor $inactiveTextColor) 
amount=$(cat $thisPath/ApplicationsToLaunch.txt | grep $selected | wc -l)

if [ $amount -eq 1 ]
then
	sh $scriptsFolder/$selected.sh
	if [ $? -gt 0 ] 
	then
		echo there is no $selected.sh Script to launch | sh $thisPath/.startThemedRofi.sh $backgroundColor "#ffffff" "#ff0000" $inactiveTextColor
	fi
else
	[[ -z $selected ]] && exit
	response=$(calc $selected)
	if [ $? -eq 0 ]
	then
		echo $selected = $response | sh $thisPath/.startThemedRofi.sh $backgroundColor "#222222" "#00ff00" $inactiveTextColor
	else
		cd ~
		$selected
		if [ $? -ne 0 ] 
		then
			echo $errorPrompt | sh $thisPath/.startThemedRofi.sh $backgroundColor "#ffffff" "#ff0000" $inactiveTextColor
		fi
	fi
fi

