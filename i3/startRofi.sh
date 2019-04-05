#!/bin/bash
backgroundColor=$1
activeTextColor=$2
currentActiveColor=$3
inactiveTextColor=$4
borderColor=$5
if [[ ! -z $6 ]] 
then 
	params="$6 -p Application|Calc"
else 
	params="-p Application|Calc"
fi
echo $params
thisPath=~/.config/i3
scriptsFolder=$thisPath/Applications
errorPrompt="Unknown Command"

ApplicationsAmount=$(cat $thisPath/ApplicationsToLaunch.txt | grep .|  wc -l) 
if [ $ApplicationsAmount -gt 10 ]
then
	ApplicationsAmount=10
fi
selected=$(cat $thisPath/ApplicationsToLaunch.txt| grep . | sort | sh $thisPath/startThemedRofi.sh $backgroundColor $activeTextColor $currentActiveColor $inactiveTextColor $borderColor "$params -lines $ApplicationsAmount")  
amount=$(cat $thisPath/ApplicationsToLaunch.txt | grep -w $selected | wc -l)
if [ $amount -eq 1 ]
then
	sh $scriptsFolder/$selected.sh
	if [ $? -gt 0 ] 
	then
		echo there is no $selected.sh Script to launch | sh $thisPath/startThemedRofi.sh $backgroundColor "#ffffff" "#ff0000" $inactiveTextColor $borderColor "$params -lines 1 -hide-scrollbar"
	fi
else
	[[ -z $selected ]] && exit
	response=$(calc $selected)
	if [ $? -eq 0 ]
	then
		echo $selected = $response | sh $thisPath/startThemedRofi.sh $backgroundColor "#222222" "#00ff00" $inactiveTextColor $borderColor "$params -lines 1 -hide-scrollbar"
	else
		cd ~
		$selected
		if [ $? -ne 0 ] 
		then
			echo $errorPrompt | sh $thisPath/startThemedRofi.sh $backgroundColor $activeTextColor "#ff0000" $inactiveTextColor $borderColor "-lines 1a -hide-scrollbar"
		fi
	fi
fi

