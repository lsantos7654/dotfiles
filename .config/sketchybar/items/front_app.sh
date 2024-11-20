#!/bin/bash

FRONT_APP_SCRIPT='
    ICON=$($CONFIG_DIR/plugins/icon_map_fn.sh "$INFO")
    sketchybar --set $NAME label="$INFO" icon="$ICON"
'

front_app=(
	script="$PLUGIN_DIR/front_app.sh"
	icon.drawing=on
	icon.padding_right=8
	padding_left=-20
	label.color=$WHITE
	icon.color=$WHITE
	label.font="$FONT:Black:12.0"
	icon.font="sketchybar-app-font:Regular:14.0"
	associated_display=active
)

separator=(
	label="│"
	label.color=$WHITE
	label.font="$FONT:Bold:18.0"
	padding_left=-20
	padding_right=4
	associated_display=active
)

# Add the separator first
sketchybar --add item separator left \
	--set separator "${separator[@]}"

# Then add the front_app
sketchybar --add item front_app left \
	--set front_app "${front_app[@]}" \
	--subscribe front_app front_app_switched
