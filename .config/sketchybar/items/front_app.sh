#!/bin/bash

FRONT_APP_SCRIPT='
    ICON=$($CONFIG_DIR/plugins/icon_map_fn.sh "$INFO")
    sketchybar --set $NAME label="$INFO" icon="$ICON"
'

front_app=(
	script="$PLUGIN_DIR/front_app.sh"
	icon.drawing=on
	icon.padding_right=8
	padding_left=0
	label.color=$WHITE
	icon.color=$WHITE
	label.font="$FONT:Black:12.0"
	icon.font="sketchybar-app-font:Regular:14.0"
	associated_display=active
)

sketchybar --add item front_app left \
	--set front_app "${front_app[@]}" \
	--subscribe front_app front_app_switched
