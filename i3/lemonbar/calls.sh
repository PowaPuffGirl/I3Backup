#!/bin/basah

volume=$( sh getVolume.sh )
brightness=$( sh getBrightness.sh )
wifi=$( sh getWifi.sh )
temp=$( sh getTemperature.sh )
load=$( sh getWorkload.sh )
battery=$( sh getBatteryStats.sh )
connection=$( sh getConnectionStrength.sh )

sec5=0
sec3=0
sec30=0

while true; do
	time=$( date +%s )
	if [[ $(($time%30)) -eq 0 ]] && [[ $sec30 == 0 ]]
	then 
		battery=$( sh getBatteryStats.sh )
		sec30=1
	else
		sec30=0
	fi
	if [[ $(($time%5)) -eq 0 ]] && [[ $sec5 == 0 ]]
	then
		load=$( sh getWorkload.sh )
		temp=$( sh getTemperature.sh )
		wifi=$( sh getWifi.sh )
		sec5=1
	else 
		sec5=0
	fi
	if [[ $(($time%3)) -eq 0 ]] && [[ $sec3 == 0 ]]
	then
		connection=$( sh getConnectionStrength.sh )
		sec3=1
	else
		sec3=0
	fi
	volume=$( sh getVolume.sh )
	brightness=$( sh getBrightness.sh )
	
	echo "%{r} $volume$brightness$wifi$temp$load$battery$( sh getTime.sh )$connection%{B#111111}"
	sleep 1
done
