#!/bin/bash

# Script to handle smart window focus with display wrapping
direction=$1 # 'east' or 'west'
YABAI="/opt/homebrew/bin/yabai"

# Get current window and display info
current_window=$($YABAI -m query --windows --window)
current_display=$($YABAI -m query --displays --window)

# Check if there's a window in the requested direction on current display
next_window=$($YABAI -m window --focus $direction 2>&1)

if [[ $? -ne 0 ]]; then
	# No window found in direction, so move to next/prev display
	if [[ "$direction" == "west" ]]; then
		$YABAI -m display --focus next || $YABAI -m display --focus first
	else
		$YABAI -m display --focus prev || $YABAI -m display --focus last
	fi
fi
