#!/usr/bin/bash

# Define the clock
Clock() {
        DATETIME=$(date "+%a %b %d, %T")

        echo -n "$DATETIME"	
}

Battery() {
        BATPERC=$(acpi --battery | cut -d, -f2)
        echo " "
}

# Print the clock

while true; do
	echo "%{c}%{F#FFFF00}%{B#0000FF} $(Clock) %{F-}%{B-} %{r}$(Battery)"
        sleep 1
done

