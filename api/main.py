from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/print_payload', methods=['POST'])
def print_payload():
    data = request.json  # assuming the payload is in JSON format
    print("Received payload:", data)
    return jsonify({"message": "Payload received successfully"})

if __name__ == '__main__':
    app.run(debug=True, port=8081)
