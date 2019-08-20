#!/bin/python3 


from flask import Flask


app = Flask(__name__)


@app.route("/")
def hello():
    return "Hello World (Self-Signed)!"


if __name__ == "__main__":
    app.run(host='0.0.0.0', ssl_context=('cert.pem', 'key.pem'))
