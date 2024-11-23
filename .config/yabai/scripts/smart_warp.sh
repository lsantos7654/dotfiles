#!/bin/bash

YABAI="/opt/homebrew/bin/yabai"
direction=$1 # 'east' or 'west'

# Get current window and space info
current_space=$($YABAI -m query --spaces --space | jq '.index')
current_window=$($YABAI -m query --windows --window | jq '.id')
main_space=$($YABAI -m query --spaces | jq '.[] | select(.display == 1 and ."is-visible" == true and .index <= 10).index')

# Try to warp in the specified direction first
$YABAI -m window --warp $direction 2>/dev/null
if [[ $? -eq 0 ]]; then
	exit 0
fi

# If warp failed, handle the special cases
if [[ $current_space -le 10 ]]; then
	# We're in the main display (spaces 1-10)
	if [[ "$direction" == "west" ]]; then
		# Try to move to left display (space 11)
		$YABAI -m window --space 11
		$YABAI -m space --focus 11
	elif [[ "$direction" == "east" ]]; then
		# Try to move to right display (space 12)
		$YABAI -m window --space 12
		$YABAI -m space --focus 12
	fi
elif [[ $current_space -eq 11 ]]; then
	# We're in the left display
	if [[ "$direction" == "east" ]]; then
		# Move to main display's current space
		$YABAI -m window --space $main_space
		$YABAI -m space --focus $main_space
	elif [[ "$direction" == "west" ]]; then
		# Try to move to right display (space 12)
		$YABAI -m window --space 12
		$YABAI -m space --focus 12
	fi
elif [[ $current_space -eq 12 ]]; then
	# We're in the right display
	if [[ "$direction" == "west" ]]; then
		# Move to main display's current space
		$YABAI -m window --space $main_space
		$YABAI -m space --focus $main_space
	elif [[ "$direction" == "east" ]]; then
		# Try to move to right display (space 12)
		$YABAI -m window --space 11
		$YABAI -m space --focus 11
	fi
fi
