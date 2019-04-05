#!/bin/bash
ipString=$( nmcli -p device show | grep "GENERAL.STATE:" )
connected=$( echo $ipString | cut -d ' ' -f 2 )

if [[ $connected -eq 100 ]]
then
	ip=$( nmcli -p device show | grep "IP4.ADDRESS" )
	ip=$( echo $ip | cut -d ' ' -f 2 )
	ip=$( echo $ip | cut -d '/' -f 1 )
	printf "%s" "%{F#00ff00} %{B#111111}$ip"
else
	printf "%s" "%{F#ff0000} %{B#111111}WIFI DOWN"
fi

