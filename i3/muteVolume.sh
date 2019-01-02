#!/bin/bash

getsink() {
    pacmd list-sinks |
        awk '/index:/{i++} /* index:/{print i; exit}'
}

getIndex() {
    pacmd list-sinks |
        awk '/index: /{i++} i=='$(getsink)'{print $3; exit}'

}

pactl set-sink-mute $(getIndex) $1
