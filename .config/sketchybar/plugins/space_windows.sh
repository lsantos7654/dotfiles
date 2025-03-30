#!/bin/bash

case "$SENDER" in
"front_app_switched" | "space_change" | "space_windows_change" | "display_change")
	space="$(echo "$INFO" | jq -r '.space')"

	# If space is empty in the event info, get the current space
	if [ -z "$space" ] || [ "$space" = "null" ]; then
		space=$(yabai -m query --spaces --space | jq -r '.index')
	fi

	# Get windows in the space
	WINDOWS="$(yabai -m query --windows --space $space)"

	icon_strip=""
	has_windows=false

	# Check if WINDOWS is empty or just contains empty brackets
	if [ -n "$WINDOWS" ] && [ "$WINDOWS" != "[]" ]; then
		while IFS= read -r window; do
			app=$(echo "$window" | jq -r '.app')
			is_minimized=$(echo "$window" | jq -r '."is-minimized"')

			if [ -n "$app" ] && [ "$is_minimized" = "false" ]; then
				icon_strip+=" $($CONFIG_DIR/plugins/icon_map_fn.sh "$app")"
				has_windows=true
			fi
		done < <(echo "$WINDOWS" | jq -c '.[]')
	fi

	# If no windows were added or the space is empty
	if [ "$has_windows" = false ]; then
		icon_strip=" —"
	fi

	# Force update the label even if it appears unchanged
	sketchybar --set space.$space label="$icon_strip" \
		label.background.drawing=on \
		label.background.color=$BACKGROUND_1 \
		label.drawing=on

esac
