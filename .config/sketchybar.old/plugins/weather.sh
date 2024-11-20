#!/bin/bash

# Modified weather.sh plugin to be more compact
update_weather() {
	# Using wttr.in with a more compact format - just temp and condition icon
	weather_data=$(curl -s "wttr.in/?format=%t")

	if [ $? -eq 0 ]; then
		echo "$weather_data"
	else
		echo "N/A"
	fi
}

WEATHER=$(update_weather)
# Remove the space between the + and degree symbol to make it more compact
WEATHER=$(echo "$WEATHER" | sed 's/+//' | sed 's/ //g')

sketchybar --set $NAME label="$WEATHER" icon="󰖐"
