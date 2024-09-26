import spotipy
from spotipy.oauth2 import SpotifyOAuth
import os


def get_spotify_client():
    scope = "user-read-playback-state user-modify-playback-state"

    token_cache_path = os.path.join(
        os.getenv("HOME"), ".spotify", "spotify_token-cache"
    )
    os.makedirs(os.path.dirname(token_cache_path), exist_ok=True)

    return spotipy.Spotify(
        auth_manager=SpotifyOAuth(scope=scope, cache_path=token_cache_path)
    )
