#!/bin/bash

SPACE_SIDS=(1 2 3 4 5 6 7 8 9 10)

for sid in "${SPACE_SIDS[@]}"; do
	sketchybar --add space space.$sid left \
		--set space.$sid space=$sid \
		icon=$sid \
		label.font="sketchybar-app-font:Regular:12.0" \
		label.padding_right=10 \
		label.padding_left=0 \
		label.y_offset=-1 \
		background.extending_left=0 \
		background.extending_right=0 \
		background.color=$ITEM_BG_COLOR \
		label.background.drawing=on \
		label.background.color=$ITEM_BG_COLOR \
		click_script="yabai -m space --focus $sid" \
		script="$PLUGIN_DIR/space.sh"
done

sketchybar --add item space_separator left \
	--set space_separator icon="" \
	icon.color=$ACCENT_COLOR \
	icon.padding_left=4 \
	label.drawing=off \
	background.drawing=off \
	script="$PLUGIN_DIR/space_windows.sh" \
	--subscribe space_separator space_windows_change