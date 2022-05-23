from flask import Flask, jsonify
from flask_cors import CORS

images = [
    {
        "img_id": 1,
        "img_src":
        "https://techmonitor.ai/wp-content/uploads/sites/4/2016/06/what-is-URL.jpg"
    },
    {
        "img_id": 2,
        "img_src":
        "https://www.dignited.com/wp-content/uploads/2018/09/url_istock_nicozorn_thumb800.jpg"
    },
    {
        "img_id": 3,
        "img_src":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b2/WindparkBeltheimII_%28hochkant%29.jpg/1200px-WindparkBeltheimII_%28hochkant%29.jpg"
    },
    {
        "img_id": 4,
        "img_src":
        "https://techmonitor.ai/wp-content/uploads/sites/4/2016/06/what-is-URL.jpg"
    },
    {
        "img_id": 5,
        "img_src":
        "https://www.dignited.com/wp-content/uploads/2018/09/url_istock_nicozorn_thumb800.jpg"
    },
    {
        "img_id": 6,
        "img_src":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b2/WindparkBeltheimII_%28hochkant%29.jpg/1200px-WindparkBeltheimII_%28hochkant%29.jpg"
    },
    {
        "img_id": 7,
        "img_src":
        "https://techmonitor.ai/wp-content/uploads/sites/4/2016/06/what-is-URL.jpg"
    },
    {
        "img_id": 8,
        "img_src":
        "https://www.dignited.com/wp-content/uploads/2018/09/url_istock_nicozorn_thumb800.jpg"
    },
    {
        "img_id": 9,
        "img_src":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b2/WindparkBeltheimII_%28hochkant%29.jpg/1200px-WindparkBeltheimII_%28hochkant%29.jpg"
    },
    {
        "img_id": 10,
        "img_src":
        "https://techmonitor.ai/wp-content/uploads/sites/4/2016/06/what-is-URL.jpg"
    },
    {
        "img_id": 11,
        "img_src":
        "https://www.dignited.com/wp-content/uploads/2018/09/url_istock_nicozorn_thumb800.jpg"
    },
    {
        "img_id": 12,
        "img_src":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b2/WindparkBeltheimII_%28hochkant%29.jpg/1200px-WindparkBeltheimII_%28hochkant%29.jpg"
    }
]

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


@app.route('/images', methods=['GET'])
def data():
    return jsonify({
        'status': 'success',
        'data': images,
    })


if __name__ == '__main__':
    app.run()
