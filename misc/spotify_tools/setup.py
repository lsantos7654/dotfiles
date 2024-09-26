from setuptools import setup, find_packages

setup(
    name="spotify-control",
    version="0.1",
    packages=find_packages(where="src"),
    package_dir={"": "src"},
    install_requires=[
        "spotipy",
    ],
    entry_points={
        "console_scripts": [
            "spotify-next=spotify_control.next_song:main",
            "spotify-previous=spotify_control.previous_song:main",
            "spotify-play-pause=spotify_control.play_pause:main",
            "spotify-volume-up=spotify_control.volume_up:main",
            "spotify-volume-down=spotify_control.volume_down:main",
        ],
    },
)
