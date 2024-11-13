#!/bin/bash

update_windows() {
	# Remove all previous window items
	sketchybar --remove '/window\..*/'

	# Get all windows in current space, excluding Finder if it's that extra block
	WINDOWS=$(yabai -m query --windows --space | jq -c '[.[] | select(.app != "Finder" or .title != "")]')

	# Get the id of the focused window
	FOCUSED_WINDOW=$(yabai -m query --windows --window | jq -r '.id')

	# Process each window, sort by x position to maintain order
	echo "$WINDOWS" | jq -c 'sort_by(.frame.x) | .[]' | while read -r window; do
		APP=$(echo "$window" | jq -r '.app')
		ID=$(echo "$window" | jq -r '.id')

		# Generate a unique item name for this window
		ITEM_NAME="window.$ID"

		# Get the icon for the app
		ICON="$($CONFIG_DIR/plugins/icon_map_fn.sh "$APP")"

		# Add item for this window
		sketchybar --add item "$ITEM_NAME" left \
			--set "$ITEM_NAME" \
			icon="$ICON" \
			icon.font="sketchybar-app-font:Regular:16.0" \
			icon.padding_left=8 \
			icon.padding_right=8 \
			background.corner_radius=3 \
			background.padding_left=3 \
			background.padding_right=3 \
			background.height=22 \
			background.color=0x00000000

		# If this is the focused window, set white background
		if [ "$ID" = "$FOCUSED_WINDOW" ]; then
			sketchybar --set "$ITEM_NAME" background.color=0xFFFFFFFF icon.color=0xFF000000
		else
			sketchybar --set "$ITEM_NAME" background.color=0x00000000 icon.color=0xFFFFFFFF
		fi
	done
}

case "$SENDER" in
"forced" | "front_app_switched" | "space_change" | "window_focus" | "application_launched" | "application_terminated" | "window_created" | "window_destroyed" | "window_close | application_quit")
	update_windows
	;;
esac
