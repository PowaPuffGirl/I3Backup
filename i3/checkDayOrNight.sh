#!/bin/bash

hour=$( date "+%H" )
mins=$( date "+%M" )
secs=$( date "+%S" )
timer=$(( (15-$hour)*60*60 + (25-$mins)*60 + (60-$secs) ))
echo $timer
if [[ $timer -gt 0 ]] 
then
	sleep $timer
fi
sh changeDisplayColor.sh 5100 6500
