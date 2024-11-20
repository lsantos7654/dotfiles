#!/bin/bash

source "$CONFIG_DIR/colors.sh"

case "$SENDER" in
"front_app_switched" | "window_focus" | "space_change")
	WINDOWS=$(yabai -m query --windows --space)
	sketchybar --remove '/window_.*/'

	counter=0

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
	;;
esac
