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

[[ -z $selected ]] && exit

case $selected in
"Dual Monitor")
bash -x DualMonitor.sh
    ;;
"Duplicate")
sh Duplicate.sh
    ;;
"Display Only")
sh OnlyDisplay.sh
    ;;
"Monitor Only")
sh OnlySecondScreen.sh
    ;;
"Monitor Only QHD")
sh OnlySecondScreenQHD.sh
    ;;
"Reset")
sh Reset.sh
    ;;
"Monitor Above")
sh SecondScreenAbove.sh
    ;;
"Monitor Below")
sh SecondScreenBelow.sh
    ;;
"Monitor Left")
sh SecondScreenToLeft.sh
    ;;
"Monitor Right")
sh SecondScreenToRight.sh
    ;;
*)
echo $errorPrompt | sh $thisPath/.startThemedRofi.sh $backgroundColor $activeTextColor "#ff0000" $inactiveTextColor $borderColor "-p Display -lines 1 -hide-scrollbar"
    ;;
esac

