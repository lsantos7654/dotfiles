#!/bin/bash

if [ "$SENDER" = "space_windows_change" ]; then
	space="$(echo "$INFO" | jq -r '.space')"

	# Check first-window value for the space
	SPACE_INFO="$(yabai -m query --spaces | jq -r ".[] | select(.index==$space)")"
	FIRST_WINDOW="$(echo "$SPACE_INFO" | jq -r '."first-window"')"

	# If first-window is 0, set empty icon strip and exit
	if [ "$FIRST_WINDOW" = "0" ]; then
		sketchybar --set space.$space label=" —" \
			label.background.drawing=on \
			label.background.color=$BACKGROUND_1
		exit 0
	fi

	# Get all active windows from yabai
	ALL_WINDOWS="$(yabai -m query --windows)"

	# Get windows for the specific space
	SPACE_WINDOWS="$(yabai -m query --windows --space $space)"

	icon_strip=""
	has_windows=false

	if [ -n "$SPACE_WINDOWS" ] && [ "$SPACE_WINDOWS" != "[]" ]; then
		while IFS= read -r window; do
			window_id=$(echo "$window" | jq -r '.id')
			# Check if this window exists in ALL_WINDOWS
			window_exists=$(echo "$ALL_WINDOWS" | jq -r ".[] | select(.id==$window_id) | .id")

			if [ -n "$window_exists" ]; then
				app=$(echo "$window" | jq -r '.app')
				is_minimized=$(echo "$window" | jq -r '."is-minimized"')

				if [ -n "$app" ] && [ "$is_minimized" = "false" ]; then
					icon_strip+=" $($CONFIG_DIR/plugins/icon_map_fn.sh "$app")"
					has_windows=true
				fi
			fi
		done < <(echo "$SPACE_WINDOWS" | jq -c '.[]')
	fi

	# If no windows were added or the space is empty
	if [ "$has_windows" = false ] || [ -z "$icon_strip" ]; then
		icon_strip=" —"
	fi

	sketchybar --set space.$space label="$icon_strip" \
		label.background.drawing=on \
		label.background.color=$BACKGROUND_1
fi
