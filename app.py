from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
    return "2 o 2 yay howejfo!"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)