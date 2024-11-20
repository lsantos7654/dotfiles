#!/bin/bash

sketchybar --add item front_app left \
	--set front_app background.color=$ACCENT_COLOR \
	icon.color=$BAR_COLOR \
	icon.font="sketchybar-app-font:Regular:16.0" \
	label.color=$BAR_COLOR \
	script="$PLUGIN_DIR/front_app.sh" \
	--add event window_focus \
	--add event space_change \
	--add event front_app_switched \
	--add event window_created \
	--add event window_destroyed \
	--add event window_moved \
	--subscribe front_app \
	front_app_switched \
	space_change \
	window_focus \
	window_destroy \
	window_created \
	window_moved \
	application_terminated \
	application_launched \
	application_quit \
	window_close
