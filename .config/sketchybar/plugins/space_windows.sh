#!/bin/bash

if [ "$SENDER" = "space_windows_change" ]; then
	space="$(echo "$INFO" | jq -r '.space')"
	# Get only non-minimized windows by checking "is-minimized": false
	WINDOWS="$(yabai -m query --windows --space $space)"

	icon_strip=" "
	if [ -n "$WINDOWS" ]; then
		while IFS= read -r window; do
			app=$(echo "$window" | jq -r '.app')
			is_minimized=$(echo "$window" | jq -r '."is-minimized"')

			if [ -n "$app" ] && [ "$is_minimized" = "false" ]; then
				icon_strip+=" $($CONFIG_DIR/plugins/icon_map_fn.sh "$app")"
			fi
		done < <(echo "$WINDOWS" | jq -c '.[]')
	else
		icon_strip=" —"
	fi

	sketchybar --set space.$space label="$icon_strip" \
		label.background.drawing=on \
		label.background.color=$BACKGROUND_1
fi
