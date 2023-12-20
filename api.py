from flask import Flask
from models import db
from os import getenv
from api.v1.core import v1_blueprint  # Importing the Blueprint

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = f"mysql://{getenv('DB_USER')}:{getenv('DB_PASSWORD')}@localhost/{getenv('DB_NAME')}"
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db.init_app(app)
with app.app_context():
    db.create_all()

# Registering the Blueprint with the app
app.register_blueprint(v1_blueprint, url_prefix="/api/v1")

if __name__ == '__main__':
    app.run(debug=True, port=5001)
