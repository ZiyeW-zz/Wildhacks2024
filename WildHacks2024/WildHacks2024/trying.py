import requests
import spotipy
from spotipy.oauth2 import SpotifyOAuth
import pandas as pd
import time
import datetime
from flask import Flask, request, jsonify, session, redirect
from werkzeug.security import generate_password_hash, check_password_hash
from flask_sqlalchemy import SQLAlchemy


db = SQLAlchemy()

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    password = db.Column(db.String(80), nullable=False)

app = Flask(__name__)
 
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

#USER DATA
user_data = sp.current_user()
username = user_data['display_name']
#print(f"Username: {username}")

@app.route('/login')
def login():
    auth_url = sp.get_authorize_url()
    return redirect(auth_url)

@app.route('/spotify_callback')
def spotify_callback():
    code = request.args.get('code')
    token_info = sp.auth_manager.get_access_token(code, as_dict=False)
    # At this point, the user has been authenticated, and you can use the access token to make authorized calls to the Spotify API.
    # Redirect the user to another endpoint, e.g., a page that shows their top tracks.
    return redirect('/get-top-tracks') #change this to the main page


#START OF THE USER PERSONA ALGORITHM

#PULL USER INFO -- Top Tracks and Top Artists
#Fetch user's top tracks over a 4 week period 
top_tracks_short = sp.current_user_top_tracks(limit=50, offset=0, time_range="short_term")


#Fetch user's recently played tracks
recently_played = sp.current_user_recently_played(limit=50, after=None, before=None) #after/before args might be omitted

# Fetch user's top artists
top_artists = sp.current_user_top_artists(limit=10, offset=0, time_range="short_term")

# Fetch track IDs from top_tracks_short and recently_played
track_ids = [track['id'] for track in top_tracks_short['items']]
track_ids2 = [item['track']['id'] for item in recently_played['items']]
combined_track_ids = track_ids + track_ids2


@app.route("/get-user/<user_id>")
def get_user(user_id):
    user_data = {
        "user_id": user_id,
        "email": "john.doe@example.com",
        "persona": "sad"
}

    return jsonify(user_data), 200

#Probably important later on if we want to add auth
@app.route("/create-user", methods=["POST"])
def create_user():
    data = request.get_json()
    return jsonify(data), 201
#add to database




#API ROUTES FOR THE ABOVE USER DATA
@app.route('/get-top-tracks', methods=['GET'])
#GETS user's top tracks
def get_tracks():
    return jsonify(top_tracks_short), 200

@app.route('/get-top-artists', methods=['GET'])
#GETS user's top artists
def get_artists():
    return jsonify(top_artists), 200

@app.route('/get-recently-played', methods=['GET'])
#GETS user's recently played tracks
def get_recently_played():
    return jsonify(recently_played), 200

@app.route('/get-track-ids', methods=['GET'])
#GETS track ids for recent and top tracks
def get_track_ids():
    return jsonify(combined_track_ids), 200


#PULL AUDIO FEATURES AND ANALYZE TO INFER MOOD

# Analyze audio features to infer mood
#audio_features is a list of features for each track
audio_features = sp.audio_features(combined_track_ids)

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

# #API ROUTE FOR THE PERSONA
# @app.route('/get-persona', methods=['GET'])
# def get_persona():
#     return jsonify(dominant_mood), 200



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
# print(recommended_tracks)

# Getting the album images for each track in the 
image_urls = []
for track in recommended_tracks: 
    results = sp.search(q=track, type="track")
    items = results['tracks']['items']
    if len(items) > 0:
        album = items[0]
        image_url = album.get('images', [{}])[0].get('url', 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fgithub.com%2Fquoka&psig=AOvVaw3bU1CBvyCRe5UDCBYh8t7i&ust=1712596938575000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCPCL-fLOsIUDFQAAAAAdAAAAABAE')
        image_urls.append(image_url)
        print(album['name'], image_url)


#API ROUTE FOR THE PERSONA
@app.route('/get-persona', methods=['GET'])
def get_persona():
    return jsonify(dominant_mood), 200

#API ROUTES FOR SONG RECOMMENDATIONS
@app.route('/get-recommendations', methods=['GET'])
def get_rec_tracks():
    desiredmood = request.args.get('desiredmood')
    seed_artists = [artist['id'] for artist in top_artists['items']] # could be global variable

    # Assuming combined_track_ids is a list of track IDs
    seed_tracks = combined_track_ids  # could be global variable

    listOfRecs = get_recommendations(sp, seed_artists, seed_tracks, desiredmood)
    return jsonify(listOfRecs), 200

@app.route('/get-image-urls', methods=['GET'])
def get_image_urls():
    return jsonify(image_urls), 200

if __name__ == "__main__":
    app.run(debug = True)


# @app.route("/get-user/<user_id>")
# def get_user(user_id):
#     user_data = {
#         "user_id": user_id,
#         "email": "john.doe@example.com",
#         "persona": "sad"
# }

#     return jsonify(user_data), 200