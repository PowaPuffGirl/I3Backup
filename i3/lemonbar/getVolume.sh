#!/bin/bash

volumeString=$( amixer sget Master )
volumeString=$( echo $volumeString | cut -d '[' -f 2 )
volume=$( echo $volumeString | cut -d ']' -f 1 )

printf "%s" "%{F#ffffff} %{B#111111} $volume"

