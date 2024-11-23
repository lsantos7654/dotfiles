#!/bin/bash

cpu_percent=(
	icon="󰍛" # CPU icon from nerd fonts
	icon.font="$FONT:Bold:16"
	icon.color=$WHITE
	label.font="$FONT:Heavy:12"
	label.color=$WHITE
	update_freq=2
	mach_helper="$HELPER"
	padding_right=0
	width=55
)

sketchybar --add item cpu.percent right \
	--set cpu.percent "${cpu_percent[@]}"
