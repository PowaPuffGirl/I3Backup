#!/bin/bash

getsink() {
    pacmd list-sinks |
        awk '/index:/{i++} /* index:/{print i; exit}'
}

getIndex() {
    pacmd list-sinks |
        awk '/index: /{i++} i=='$(getsink)'{print $3; exit}'

}

checkMute() {
    pacmd list-sinks |
        awk '/^\smuted: /{i++} i=='$(getsink)'{print $2; exit}'

}

getValue() {
	pacmd list-sinks |
        awk '/^\svolume:/{i++} i=='$(getsink)'{print $5; exit}'
}

if [[ $(checkMute) == 'no' ]]
then
	volume=$(getValue)
	volume=${volume%?}
	value=${1%?}
	value=$(($value + $volume))
	if [[ $value -lt 0 ]] 
	then 
		value=0
	fi

	if [[  $value -gt 100 ]] 
	then
		value=100
	fi
	pactl set-sink-volume $(getIndex) "$value%"
fi
