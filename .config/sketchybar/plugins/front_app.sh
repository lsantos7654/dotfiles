#!/bin/bash

source "$CONFIG_DIR/colors.sh"

case "$SENDER" in
"front_app_switched" | "space_change" | "space_windows_change" | "display_change")
	# Get all visible spaces
	VISIBLE_SPACES=$(yabai -m query --spaces | jq '.[] | select(."is-visible" == true).index')

	# Remove existing window items
	sketchybar --remove '/window_.*/'

	counter=0

	# Loop through each visible space
	while IFS= read -r space; do
		# Check first-window value for the space
		SPACE_INFO=$(yabai -m query --spaces | jq -r ".[] | select(.index==$space)")
		FIRST_WINDOW=$(echo "$SPACE_INFO" | jq -r '."first-window"')

		# Skip if first-window is 0
		if [ "$FIRST_WINDOW" = "0" ]; then
			continue
		fi

		WINDOWS=$(yabai -m query --windows --space "$space")

		while IFS= read -r window; do
			app=$(echo "$window" | jq -r '.app')
			has_focus=$(echo "$window" | jq -r '."has-focus"')

			if [ -n "$app" ]; then
				APP_ICON=$($CONFIG_DIR/plugins/icon_map_fn.sh "$app")
				ITEM_NAME="window_${counter}"

				sketchybar --add item "$ITEM_NAME" left

				sketchybar --set "$ITEM_NAME" \
					icon="$APP_ICON" \
					label="" \
					icon.font="sketchybar-app-font:Regular:14.0" \
					icon.padding_right=4 \
					padding_right=-4

				if [ "$has_focus" = "true" ]; then
					sketchybar --set "$ITEM_NAME" icon.color=$BLUE
				else
					sketchybar --set "$ITEM_NAME" icon.color=$GREY
				fi

				counter=$((counter + 1))
			fi
		done < <(echo "$WINDOWS" | jq -c '.[]' | sort)
	done < <(echo "$VISIBLE_SPACES")
	;;
esac
