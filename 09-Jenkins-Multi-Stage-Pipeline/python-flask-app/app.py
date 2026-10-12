from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return "Hello, Jenkins Multi-Stage Pipeline!"

if __name__ == "__main__":
    # use_reloader=False: the debug reloader forks a child, which breaks the
    # PID captured by the Jenkins "Run Application" stage.
    app.run(debug=True, use_reloader=False)
