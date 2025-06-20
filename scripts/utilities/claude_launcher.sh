#!/bin/bash
# Launch Claude AI in fullscreen Firefox window

# Check if Firefox is installed
if ! command -v firefox &> /dev/null; then
    echo "Error: Firefox is not installed"
    exit 1
fi

# Check if xdotool is installed for fullscreen toggle
if ! command -v xdotool &> /dev/null; then
    echo "Warning: xdotool not installed. Opening without fullscreen."
    firefox -new-window https://claude.ai/new &
    exit 0
fi

# Open Firefox with Claude AI
firefox -new-window https://claude.ai/new &

# Wait for window to load
sleep 1

# Toggle fullscreen
xdotool key F11
