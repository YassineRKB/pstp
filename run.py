#!/usr/bin/python3
"""models run"""
from flask import Flask, render_template, jsonify
from flask_migrate import Migrate
from sqlalchemy import or_
from models.db import db
from os import getenv
from models.shelter import ShelterOverview
from models.client import Client
from models.pet import Pet
from models.medical_history import MedicalHistory
from models.blog import Blog
from models.food import Food
from models.user import User

app = Flask(__name__, template_folder='public/templates')
app.config['SQLALCHEMY_DATABASE_URI'] = f"mysql://{getenv('DB_USER')}:{getenv('DB_PASSWORD')}@localhost/{getenv('DB_NAME')}"
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db.init_app(app)
migrate = Migrate(app, db)

# Routes
@app.route('/')
@app.route('/home')
def home():
    """Home page"""
    last_pets = Pet.query.filter(or_(Pet.pet_status == "not adopted")).order_by(Pet.id.desc()).limit(5).all()
    last_blogs = Blog.query.order_by(Blog.id.desc()).limit(2).all()
    return render_template('home.html', last_pets=last_pets, last_blogs=last_blogs)

@app.route('/pets')
def pets():
    """pets page"""
    pets = Pet.query.all()
    return render_template('pets.html', pets=pets)

@app.route('/pet/<int:pet_id>')
def pet(pet_id):
    """pet page"""
    pet = Pet.query.get_or_404(pet_id)
    return render_template('pet.html', pet=pet)

@app.route('/medical')
def medical():
    """medical page"""
    return render_template('medical.html')

@app.route('/blogs')
def blogs():
    """blogs page"""
    blogs = Blog.query.all()
    return render_template('blogs.html', blogs=blogs)

if __name__ == '__main__':
    app.run(debug=True)
