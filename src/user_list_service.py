# user_list_service.py
from flask import Flask, jsonify
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///users.db'
db = SQLAlchemy(app)

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(50), unique=True, nullable=False)

@app.route('/users')
def get_users():
    with app.app_context():
        users = User.query.all()
        user_list = [{'id': user.id, 'username': user.username} for user in users]
        return jsonify(user_list)

if __name__ == '__main__':
    app.run(debug=True)
