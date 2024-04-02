#!/bin/bash
# firefox -kiosk -new-window https://chat.openai.com/ &

# Open Firefox with the desired URL
firefox -new-window https://claude.ai/chats &

sleep 1

xdotool key F11

