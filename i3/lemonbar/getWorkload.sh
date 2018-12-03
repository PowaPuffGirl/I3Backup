#!/bin/bash
mpstat11=$( mpstat 1 1 | grep Aver )
avg=$( echo $mpstat11 | cut -d ' ' -f 12 )
avgValue=$( calc "100-$avg" )

printf "%s%0.2f%s" "%{F#ffffff} %{B#111111} " "$avgValue" "%"
