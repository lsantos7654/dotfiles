#!/bin/bash

# Debug logging
log_debug() {
	echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >>/tmp/sketchybar_media.log
}

log_debug "Script started"

# Spotify-specific command to get current track info
get_spotify_info() {
	log_debug "Attempting to get Spotify info..."
	RESULT=$(osascript -e 'tell application "Spotify"
        if player state is playing then
            return "{\"state\": \"playing\", \"artist\": \"" & artist of current track & "\", \"track\": \"" & name of current track & "\"}"
        else
            return "{\"state\": \"paused\"}"
        end if
    end tell')
	log_debug "Spotify info result: $RESULT"
	echo "$RESULT"
}

# Update function
update_media() {
	log_debug "Starting update_media function"
	SPOTIFY_INFO="$(get_spotify_info)"
	log_debug "Parsed Spotify info: $SPOTIFY_INFO"
	STATE=$(echo "$SPOTIFY_INFO" | jq -r '.state')
	log_debug "Current state: $STATE"

	if [ "$STATE" = "playing" ]; then
		TRACK=$(echo "$SPOTIFY_INFO" | jq -r '.track')
		ARTIST=$(echo "$SPOTIFY_INFO" | jq -r '.artist')
		log_debug "Raw track: $TRACK"
		log_debug "Raw artist: $ARTIST"

		# Trim long track/artist names
		if [ ${#TRACK} -gt 20 ]; then
			TRACK="$(echo "$TRACK" | cut -c 1-20)..."
			log_debug "Trimmed track: $TRACK"
		fi
		if [ ${#ARTIST} -gt 20 ]; then
			ARTIST="$(echo "$ARTIST" | cut -c 1-20)..."
			log_debug "Trimmed artist: $ARTIST"
		fi

		MEDIA="$TRACK - $ARTIST"
		log_debug "Setting media display to: $MEDIA"
		sketchybar --set $NAME label="$MEDIA" drawing=on icon=󰝚
	else
		log_debug "Media not playing, hiding display"
		sketchybar --set $NAME drawing=off
	fi
}

handle_click() {
	log_debug "Click detected, toggling popup"
	sketchybar --set media.controls popup.drawing=toggle
}

# Handle incoming events
log_debug "SENDER: $SENDER"
case "$SENDER" in
"media_change")
	log_debug "Received media_change event"
	update_media
	;;
"mouse.clicked")
	log_debug "Received mouse.clicked event"
	handle_click
	;;
*)
	log_debug "Unknown event: $SENDER"
	;;
esac

# Initial update
log_debug "Performing initial update"
update_media
