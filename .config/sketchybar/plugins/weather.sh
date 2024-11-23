#!/bin/bash

# Add debug logging
log_debug() {
	echo "[DEBUG] $1" >&2
}

# Weather Icons Map
get_weather_icon() {
	condition="$1"
	log_debug "Received condition: '$condition'"

	# Convert to lowercase and trim whitespace
	condition=$(echo "$condition" | tr '[:upper:]' '[:lower:]' | xargs)

	case "$condition" in
	*"clear"* | *"sunny"*)
		echo "󰖙" # Clear/Sunny
		;;
	*"partly cloudy"* | *"partly"*)
		echo "󰖕" # Partly Cloudy
		;;
	*"cloudy"* | *"overcast"*)
		echo "󰖐" # Cloudy
		;;
	*"rain"* | *"drizzle"* | *"shower"*)
		echo "󰖗" # Rain
		;;
	*"storm"* | *"thunder"* | *"heavy rain"*)
		echo "󰖖" # Storm
		;;
	*"snow"* | *"sleet"* | *"hail"*)
		echo "󰼶" # Snow
		;;
	*"mist"* | *"fog"*)
		echo "󰖑" # Fog
		;;
	*)
		log_debug "No match found for condition: '$condition', using default icon"
		echo "󰖐" # Default cloudy icon
		;;
	esac
}

update_weather() {
	# Fetch weather data with retry mechanism
	for i in {1..3}; do
		weather_data=$(curl -s "wttr.in/?format=%f|%C")
		log_debug "Raw weather data: '$weather_data'"

		if [ $? -eq 0 ] && [ ! -z "$weather_data" ]; then
			echo "$weather_data"
			return 0
		fi
		sleep 1
	done
	echo "N/A"
}

# Ensure NAME is set
if [ -z "$NAME" ]; then
	NAME="weather.module"
	log_debug "NAME was not set, using default: $NAME"
fi

WEATHER=$(update_weather)
log_debug "WEATHER: '$WEATHER'"

if [ "$WEATHER" != "N/A" ]; then
	# Process temperature - remove '+' sign and spaces
	TEMP=$(echo "$WEATHER" | cut -d'|' -f1 | sed 's/+//' | sed 's/ //g')

	# Process condition - trim whitespace and newlines
	CONDITION=$(echo "$WEATHER" | cut -d'|' -f2 | tr -d '\n' | xargs)

	log_debug "TEMP: '$TEMP'"
	log_debug "CONDITION: '$CONDITION'"

	ICON=$(get_weather_icon "$CONDITION")
	log_debug "ICON: '$ICON'"

	# Update sketchybar
	sketchybar --set "$NAME" label="$TEMP" icon="$ICON"
else
	log_debug "Weather data unavailable, setting to N/A"
	sketchybar --set "$NAME" label="N/A" icon="󰖐"
fi
