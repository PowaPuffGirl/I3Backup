#!bin/bash

max=$(cat /sys/class/backlight/intel_backlight/max_brightness)
current=$(cat /sys/class/backlight/intel_backlight/actual_brightness)
value=$(calc "100/$max*$current")
value=$( echo $value | cut -d'~' -f 2 | cut -d '.' -f 1)
printf "%s" "%{F#ffffff} %{B#111111} $value%"
