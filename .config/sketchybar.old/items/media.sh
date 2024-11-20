#!/bin/bash

# Create the main media item
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
	popup.align=center \
	popup.height=150 \
	script="$PLUGIN_DIR/media.sh" \
	update_freq=1 \
	updates=on \
	associated_space="" \
	click_script="sketchybar --set media popup.drawing=toggle" \
	--subscribe media media_change mouse.clicked

# Create the popup items
sketchybar --add item media.cover popup.media \
	--set media.cover \
	icon.drawing=off \
	label.drawing=off \
	background.padding_left=7 \
	background.padding_right=7 \
	background.height=90 \
	background.drawing=on

# Add media controls
sketchybar --add item media.controls popup.media \
	--set media.controls \
	icon="󰒮 󰏤 󰒭" \
	icon.color=$ACCENT_COLOR \
	icon.padding_left=5 \
	icon.padding_right=5 \
	background.padding_left=5 \
	background.padding_right=5 \
	click_script="$PLUGIN_DIR/media.sh --control-click \$BUTTON"
