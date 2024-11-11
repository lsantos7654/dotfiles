#!/bin/bash

# Spotify-specific command to get current track info
get_spotify_info() {
	osascript -e 'tell application "Spotify"
        if player state is playing then
            return "{\"state\": \"playing\", \"artist\": \"" & artist of current track & "\", \"track\": \"" & name of current track & "\"}"
        else
            return "{\"state\": \"paused\"}"
        end if
    end tell'
}

# Update function
update_media() {
	SPOTIFY_INFO="$(get_spotify_info)"
	STATE=$(echo "$SPOTIFY_INFO" | jq -r '.state')

	if [ "$STATE" = "playing" ]; then
		TRACK=$(echo "$SPOTIFY_INFO" | jq -r '.track')
		ARTIST=$(echo "$SPOTIFY_INFO" | jq -r '.artist')

		# Trim long track/artist names
		if [ ${#TRACK} -gt 20 ]; then
			TRACK="$(echo "$TRACK" | cut -c 1-20)..."
		fi
		if [ ${#ARTIST} -gt 20 ]; then
			ARTIST="$(echo "$ARTIST" | cut -c 1-20)..."
		fi

		MEDIA="$TRACK - $ARTIST"
		sketchybar --set $NAME label="$MEDIA" drawing=on icon=󰝚
	else
		sketchybar --set $NAME drawing=off
	fi
}

# Handle incoming events
case "$SENDER" in
"media_change")
	update_media
	;;
esac

# Initial update
update_media
