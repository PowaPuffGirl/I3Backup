#!/bin/bash

getsink() {
    pacmd list-sinks |
        awk '/index:/{i++} /* index:/{print i; exit}'
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
else 
	volume=Mute
fi

printf "%s" "%{F#ffffff} %{B#111111} $volume"

