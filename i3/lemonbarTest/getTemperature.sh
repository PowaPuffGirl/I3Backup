#!/bin/bash

tempString=$( sensors | grep "Core 1" )
tempString=$( echo $tempString | cut -d '+' -f 2 )
temp=$( echo $tempString | cut -d ' ' -f 1 )

printf "%s" "%{F#ffffff} %{B#111111} $temp"
