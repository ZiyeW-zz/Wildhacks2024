import requests
import spotipy 
from spotipy.oauth2 import SpotifyOAuth
import pandas as pd
import time
import datetime

#AUTHORIZATION INFO
SPOTIPY_CLIENT_ID = 'e6e30b2f358f4c68bf5e8320c3dca08e'
SPOTIPY_CLIENT_SECRET= 'f9d93b27421f4f0b815f2d89cdeef703'
SPOTIPY_REDIRECT_URI = 'https://127.0.0.1:9090'
SCOPE = "user-top-read"

#AUTHORIZE USER AND CLIENT
sp = spotipy.Spotify(auth_manager=SpotifyOAuth(client_id=SPOTIPY_CLIENT_ID,
                                               client_secret=SPOTIPY_CLIENT_SECRET,
                                               redirect_uri=SPOTIPY_REDIRECT_URI,
                                               scope=SCOPE))


#PULL USER INFO -- Top Tracks and Top Artists
#Testing... only pulling the top 10 tracks over 4 weeks for the user
top_tracks_short = sp.current_user_top_tracks(limit=10, offset=0, time_range="short_term")