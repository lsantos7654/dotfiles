#!/bin/bash

source "$CONFIG_DIR/colors.sh"

case "$SENDER" in
"front_app_switched" | "window_focus" | "space_change")
	echo "--- New Event: $SENDER ---" >>/tmp/sketchybar_debug.log

	# Get windows data
	WINDOWS=$(yabai -m query --windows --space)
	echo "Windows data: $WINDOWS" >>/tmp/sketchybar_debug.log

	# First, remove all existing window items
	echo "Removing existing items" >>/tmp/sketchybar_debug.log
	sketchybar --remove '/window_.*/'

	# Window counter for unique item names
	counter=0

	# Process each window
	while IFS= read -r window; do
		echo "Processing window $counter: $window" >>/tmp/sketchybar_debug.log

		app=$(echo "$window" | jq -r '.app')
		has_focus=$(echo "$window" | jq -r '."has-focus"')

		echo "App: $app, Has focus: $has_focus" >>/tmp/sketchybar_debug.log

		if [ -n "$app" ]; then
			APP_ICON=$($CONFIG_DIR/plugins/icon_map_fn.sh "$app")
			ITEM_NAME="window_${counter}"

			echo "Creating item $ITEM_NAME with icon $APP_ICON" >>/tmp/sketchybar_debug.log

			# Create the item first
			sketchybar --add item "$ITEM_NAME" left

			# Then configure it
			sketchybar --set "$ITEM_NAME" \
				icon="$APP_ICON" \
				label="" \
				icon.font="sketchybar-app-font:Regular:14.0" \
				icon.padding_right=4 \
				padding_right=4

			# Set color based on focus
			if [ "$has_focus" = "true" ]; then
				echo "Setting $ITEM_NAME to BLUE" >>/tmp/sketchybar_debug.log
				sketchybar --set "$ITEM_NAME" icon.color=$BLUE
			else
				echo "Setting $ITEM_NAME to GREY" >>/tmp/sketchybar_debug.log
				sketchybar --set "$ITEM_NAME" icon.color=$GREY
			fi

			counter=$((counter + 1))
		fi
	done < <(echo "$WINDOWS" | jq -c '.[]')

	echo "Finished processing. Created $counter items." >>/tmp/sketchybar_debug.log
	;;
esac
