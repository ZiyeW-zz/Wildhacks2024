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
SCOPE = 'user-top-read user-read-recently-played'

#AUTHORIZE USER AND CLIENT
sp = spotipy.Spotify(auth_manager=SpotifyOAuth(client_id=SPOTIPY_CLIENT_ID,
                                               client_secret=SPOTIPY_CLIENT_SECRET,
                                               redirect_uri=SPOTIPY_REDIRECT_URI,
                                               scope=SCOPE))

#START OF THE USER PERSONA ALGORITHM
#PULL USER INFO -- Top Tracks and Top Artists
#Testing... only pulling the top 50 tracks over 4 weeks for the user
top_tracks_short = sp.current_user_top_tracks(limit=50, offset=0, time_range="short_term")
#print(top_tracks_short)

#Fetch user's recently played tracks
recently_played = sp.current_user_recently_played(limit=50, after=None, before=None) #after/before args might be omitted

# Fetch user's top artists
top_artists = sp.current_user_top_artists(limit=10, offset=0, time_range="short_term")

# Print the top artists
#for idx, artist in enumerate(top_artists['items']):
#   print(f"{idx+1}. {artist['name']} - {artist['genres']}")

# Fetch track IDs from top_tracks_short and recently_played
track_ids = [track['id'] for track in top_tracks_short['items']]
track_ids2 = [item['track']['id'] for item in recently_played['items']]
combined_track_ids = track_ids + track_ids2

# Fetch audio features for these track IDs
audio_features = sp.audio_features(combined_track_ids)

# Analyze audio features to infer mood
# Here we simply print the valence, but you could perform more sophisticated analysis
#for feature in audio_features:
 #   print(f"Track ID: {feature['id']} - Valence: {feature['valence']}, Energy: {feature['energy']}, Danceability: {feature['danceability']}")

# Remember to handle None responses in audio_features and other edge cases in your final code

#Audio features: valence (0-1) - happiness, energy

#audio_features is a list of features for each track
audio_features = sp.audio_features(combined_track_ids)
#print(audio_features[1])

# Initialize counters for each mood
mood_counts = {'happy': 0, 'sad': 0, 'basic': 0, 'study': 0, 'mixed': 0}

# Analyze each track's features to categorize its mood
for feature in audio_features:
    if feature:  # Ensure feature is not None
        valence = feature['valence']
        energy = feature['energy']
        danceability = feature['danceability']
        tempo = feature['tempo']
        lyrics = feature['instrumentalness']
        #popular = feature['popularity']
        
        # Categorize based on the simplified criteria
        if valence > 0.7 and energy > 0.5:
            mood = 'happy'
        elif valence < 0.4 and energy < 0.5:
            mood = 'sad'
        elif energy > 0.6 and danceability > 0.4:
            mood = 'basic'
        elif lyrics > 0.6:
            mood = 'study'
        else:
            mood = 'mixed'  # Use this for tracks that don't fit neatly into any category
        
        mood_counts[mood] = mood_counts.get(mood, 0) + 1

# Now, let's find out the dominant mood
total_tracks = len(audio_features)
print("Mood Distribution:")
for mood, count in mood_counts.items():
    percentage = (count / total_tracks) * 100
    print(f"{mood}: {percentage:.2f}%")

# To categorize the overall music history mood:
dominant_mood = max(mood_counts, key=mood_counts.get) #could be global variable
print(f"The dominant mood in the user's music history is: {dominant_mood}")


#RECOMMENDATIONS ALGORITHM BELOW
# Extract artist IDs from top_artists (assuming top_artists is correctly fetched from Spotify API)
seed_artists = [artist['id'] for artist in top_artists['items']] # could be global variable

# Assuming combined_track_ids is a list of track IDs
seed_tracks = combined_track_ids  # could be global variable

#GENERATES THE PLAYLIST BASED ON THE MOOD YAY
def get_recommendations(sp, seed_artists, seed_tracks, dominant_mood):
    # Ensure the lists are not exceeding the Spotify limit
    seed_artists = seed_artists[:min(len(seed_artists), 2)]
    seed_tracks = seed_tracks[:min(len(seed_tracks), 3)]
    
    mood_to_criteria = {
        'happy': {'target_valence': 0.75, 'target_energy': 0.75},
        'sad': {'target_valence': 0.25, 'target_energy': 0.25},
        'basic': {'target_energy': 0.8, 'target_danceability': 0.8},
        'study': {'target_instrumentalness': 0.8},
        'mixed': {},  # Mixed mood might use a more generic recommendation criteria
    }
    criteria = mood_to_criteria.get(dominant_mood, {}) #looks for songs that fit specified attributes   
    recommendations = sp.recommendations(seed_artists=seed_artists, seed_tracks=seed_tracks, limit=15, **criteria)
    
    track_list = [] #puts the recommendations into a list
    for track in recommendations['tracks']:
        track_info = f"{track['name']} by {track['artists'][0]['name']}"
        track_list.append(track_info)
    
    return track_list

# Using the function to get recommendations (list of strings)
recommended_tracks = get_recommendations(sp, seed_artists, seed_tracks, dominant_mood) #(list of strings)-could be global variable
for track in recommended_tracks:
    print(track) # prints the songs

