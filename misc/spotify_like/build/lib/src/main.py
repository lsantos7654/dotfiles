import spotipy
from spotipy.oauth2 import SpotifyOAuth
import os


def like_current_song():
    scope = "user-library-modify user-read-currently-playing"

    token_cache_path = os.path.join(
        os.getenv("HOME"), ".spotify", "spotify_token-cache"
    )
    os.makedirs(
        os.path.dirname(token_cache_path), exist_ok=True
    )

    sp = spotipy.Spotify(auth_manager=SpotifyOAuth(
        scope=scope,
        cache_path=token_cache_path
    ))

    current_track = sp.current_user_playing_track()
    if current_track is not None:
        track_id = current_track["item"]["id"]
        sp.current_user_saved_tracks_add(tracks=[track_id])
        print("Liked the track: {}".format(current_track["item"]["name"]))
    else:
        print("No track is currently playing.")


if __name__ == "__main__":
    like_current_song()
