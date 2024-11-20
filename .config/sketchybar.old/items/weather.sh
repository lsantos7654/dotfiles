#!/bin/bash

sketchybar --add item weather right \
	--set weather \
	update_freq=1800 \
	icon.font="Hack Nerd Font:Bold:12.0" \
	label.font="Hack Nerd Font:Bold:12.0" \
	script="$PLUGIN_DIR/weather.sh" \
	background.padding_left=4 \
	background.padding_right=4 \
	label.padding_left=2 \
	label.padding_right=2 \
	icon.padding_left=2 \
	icon.padding_right=2 \
	--subscribe weather system_woke
