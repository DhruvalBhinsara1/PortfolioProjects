from flask import Flask

app = Flask(__name__)

@app.route("/")

def home():
    return "<h1>Hello, World! Welcome to my World</h1>"

@app.route("/about")

def about():
    return ("<h1>I am Dhruval Bhinsara </h1>")

@app.route('/user/<name>')
def greet_user(name):
    return f"Hello, {name} ! Nice to meet you."

@app.route('/post/<int:post_id>')
def show_post(post_id):
    return f"Viewing post number {post_id}"

if __name__ == "__main__":
    app.run(debug=True)
