#!bin/bash
value=$( xset -q | grep Caps | cut -d "o" -f 3 | cut -d " " -f 1 )

background="#ff0000"
if [[ $value == "ff" ]]
then
	background="#111111"
fi

printf "%s" "%{F#ffffff} %{B$background} "
