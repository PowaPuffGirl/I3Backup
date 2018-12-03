#!bin/bash

string=$(acpi)

A="$(cut -d' ' -f3 <<<"$string")"
B="$(cut -d' ' -f4 <<<"$string")"
C="$(cut -d' ' -f5 <<<"$string")"

if [[ $A == "Discharging," ]]
then
	remainingTextColor=""
elif [[ $A == "Full,"  ]]
then
	icon=""
	remainingTextColor=""
else 
	icon=""
	remainingTextColor="F#a4f274"
fi

value="$((${B::-2}))"

if [ 10 -gt $value ] && [ $A == "Discharging," ]
then
	printf "%s" "%{F#ffffff} %{B#ff0000} $value% (${C::-3})"
elif [[ $A == "Charging," ]] 
then
	printf "%s" "%{F#ffffff} %{B#111111} $value%%{F#a4f274}%{B#111111} (${C::-3})"
elif [[ $A == "Discharging," ]] 
then
	printf "%s" "%{F#ffffff} %{B#111111} $value%%{F#ffc17f}%{B#111111} (${C::-3})"

else
	printf "%s" "%{F#ffffff} %{B#111111} 100%%{F#a4f274}%{B#111111} (00:00)"
fi
