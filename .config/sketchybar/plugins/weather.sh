#!/bin/bash

# Weather Icons Map
get_weather_icon() {
	condition="$1"
	case "$condition" in
	"☀️" | "Clear")
		echo "󰖙" # Clear/Sunny
		;;
	"⛅️" | "🌤" | "Partly cloudy")
		echo "󰖕" # Partly Cloudy
		;;
	"☁️" | "Cloudy" | "Overcast")
		echo "󰖐" # Cloudy
		;;
	"🌧" | "Rain" | "Light rain" | "Drizzle")
		echo "󰖗" # Rain
		;;
	"⛈" | "Storm" | "Thunder" | "Heavy rain")
		echo "󰖖" # Storm
		;;
	"🌨" | "Snow" | "Light snow" | "Heavy snow")
		echo "󰼶" # Snow
		;;
	"🌫" | "Mist" | "Fog")
		echo "󰖑" # Fog
		;;
	*)
		echo "󰖐" # Default cloudy icon
		;;
	esac
}

update_weather() {
	# %t = temperature, %C = weather condition text
	weather_data=$(curl -s "wttr.in/?format=%f|%C")

	if [ $? -eq 0 ] && [ ! -z "$weather_data" ]; then
		echo "$weather_data"
	else
		echo "N/A"
	fi
}

WEATHER=$(update_weather)
if [ "$WEATHER" != "N/A" ]; then
	TEMP=$(echo "$WEATHER" | cut -d'|' -f1 | sed 's/+//' | sed 's/ //g')
	CONDITION=$(echo "$WEATHER" | cut -d'|' -f2)
	ICON=$(get_weather_icon "$CONDITION")
	sketchybar --set $NAME label="$TEMP" icon="$ICON"
else
	sketchybar --set $NAME label="N/A" icon="󰖐"
fi
