#!/bin/sh

source "$CONFIG_DIR/colors.sh" # Loads all defined colors

case "$SENDER" in
"mouse.clicked")
	# The click_script in the items file will handle the space switching
	;;
*)
	if [ $SELECTED = true ]; then
		sketchybar --set $NAME background.drawing=on \
			background.color=$ACCENT_COLOR \
			label.color=$BAR_COLOR \
			icon.color=$BAR_COLOR
	else
		sketchybar --set $NAME background.drawing=off \
			label.color=0xff2cf9ed \
			icon.color=$ACCENT_COLOR
	fi
	;;
esac
