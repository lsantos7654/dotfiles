from setuptools import setup

setup(
    name='spotify_like',
    version='0.2.0',
    packages=['spotify_like'],  # Replace with the name of the directory containing your script
    entry_points={
        'console_scripts': [
            'spotify_like = spotify_like.main:like_current_song'  # Adjust the import path as needed
        ]
    },
    install_requires=[
        'spotipy',  # List all dependencies of your script here
    ],
)
