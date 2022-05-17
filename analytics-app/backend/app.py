from flask import Flask, jsonify
from flask_cors import CORS

from data import import_data


# configuration
DEBUG = True

# instantiate the app
app = Flask(__name__)
app.config.from_object(__name__)

# enable CORS
CORS(app, resources={r'/*': {'origins': '*'}})


# sanity check route
@app.route('/ping', methods=['GET'])
def ping_pong():
    return jsonify('pong!')


@app.route('/data', methods=['GET'])
def data():
    data = import_data("data.json")
    return jsonify({
        'status': 'success',
        'data': data
    })


if __name__ == '__main__':
    app.run()
