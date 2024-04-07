from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route("/get-user/<user_id>")
def get_user(user_id):
    user_data = {
        "user_id": user_id,
        "email": "john.doe@example.com",
        "persona": "sad"
}

    return jsonify(user_data), 200


@app.route("/create-user", methods=["POST"])
def create_user():
    data = request.get_json()
    return jsonify(data), 201
#add to database


if __name__=="__main__":
    app.run(debug=True)

