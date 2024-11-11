#!/bin/bash

sketchybar --add item media e \
	--set media \
	label.color=$ACCENT_COLOR \
	icon.color=$ACCENT_COLOR \
	label.max_chars=30 \
	icon.padding_left=4 \
	icon.padding_right=4 \
	label.padding_right=8 \
	scroll_texts=on \
	icon=󰝚 \
	background.drawing=off \
	script="$PLUGIN_DIR/media.sh" \
	update_freq=1 \
	updates=on \
	associated_space="" \
	click_script="osascript -e 'tell application \"Spotify\" to playpause'" \
	--subscribe media media_change mouse.clicked
