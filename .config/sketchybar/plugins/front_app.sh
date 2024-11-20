#!/bin/bash

source "$CONFIG_DIR/colors.sh"

case "$SENDER" in
"front_app_switched" | "window_focus" | "space_change")
	WINDOWS=$(yabai -m query --windows --space)
	ICON_STRING=""

	while IFS= read -r window; do
		app=$(echo "$window" | jq -r '.app')
		has_focus=$(echo "$window" | jq -r '."has-focus"')

		if [ -n "$app" ]; then
			APP_ICON=$($CONFIG_DIR/plugins/icon_map_fn.sh "$app")
			if [ "$has_focus" = "true" ]; then
				sketchybar --set $NAME icon.color=$BLUE
			else
				sketchybar --set $NAME icon.color=$GREY
			fi
			ICON_STRING="${ICON_STRING}${APP_ICON}    "
		fi
	done < <(echo "$WINDOWS" | jq -c '.[]' | sort)

	if [ -n "$ICON_STRING" ]; then
		sketchybar --set $NAME icon="$ICON_STRING" label=""
	else
		SINGLE_ICON=$($CONFIG_DIR/plugins/icon_map_fn.sh "$INFO")
		sketchybar --set $NAME icon="$SINGLE_ICON" label=""
	fi
	;;
esac
