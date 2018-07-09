#!/bin/bash
backgroundColor=$1
activeTextColor=$2
currentActiveColor=$3
inactiveTextColor=$4
borderColor=$5

thisPath=~/.config/i3
scriptsFolder=$thisPath/ScreenCommands
errorPrompt="Unknown Mode"

selected=$(cat $thisPath/DisplayModes.txt| grep . | sort | sh $thisPath/.startThemedRofi.sh $backgroundColor $activeTextColor $currentActiveColor $inactiveTextColor $borderColor "-p Display -lines 9")  

cd $thisPath/ScreenCommands
error=""

[[ -z $selected ]] && exit

case $selected in
"Dual Monitor")
	error=$(sh DualMonitor.sh)
    ;;
"Duplicate")
	error=$(sh Duplicate.sh)
    ;;
"Display Only")
	error=$(sh OnlyDisplay.sh)
    ;;
"Monitor Only")
	error=$(sh OnlySecondScreen.sh)
    ;;
"Monitor Only QHD")
	error=$(sh OnlySecondScreenQHD.sh)
    ;;
"Reset")
	error=$(sh Reset.sh)
    ;;
"Monitor Above")
	error=$(sh SecondScreenAbove.sh)
    ;;
"Monitor Below")
	error=$(sh SecondScreenBelow.sh)
    ;;
"Monitor Left")
	error=$(sh SecondScreenToLeft.sh)
    ;;
"Monitor Right")
	error=$(sh SecondScreenToRight.sh)
    ;;
*)
echo $errorPrompt | sh $thisPath/.startThemedRofi.sh $backgroundColor $activeTextColor "#ff0000" $inactiveTextColor $borderColor "-p Display -lines 1 -hide-scrollbar"
    ;;
esac
if ! [[ -z $error ]]
then 
	echo $error | sh $thisPath/.startThemedRofi.sh $backgroundColor $activeTextColor "#ff0000" $inactiveTextColor $borderColor "-p Display -lines 1 -hide-scrollbar"
fi 

