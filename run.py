from flask import Flask, render_template, jsonify, request, session, redirect, url_for, flash
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
from functools import wraps

app = Flask(__name__, template_folder='public')
app.config['SQLALCHEMY_DATABASE_URI'] = f"mysql://{getenv('DB_USER')}:{getenv('DB_PASSWORD')}@localhost/{getenv('DB_NAME')}"
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
# add a secret key for session, right now it is just a random string and hard coded which is bad practice
app.secret_key = 'A0Zr98j3yXRXH65HjmN]LWXRT' 
db.init_app(app)
with app.app_context():
    db.create_all()


"""login required decorator"""
def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        """Check if the 'logged_in' session variable is set"""
        if 'logged_in' not in session:
            return redirect(url_for('login'))
        return f(*args, **kwargs)
    return decorated_function

@app.route('/')
@app.route('/home')
def home():
    """Home page"""
    last_pets = Pet.query.filter(or_(Pet.pet_status == "not adopted")).order_by(Pet.id.desc()).limit(5).all()
    last_blogs = Blog.query.order_by(Blog.id.desc()).limit(2).all()
    return render_template('home.html', last_pets=last_pets, last_blogs=last_blogs, active_route='home')

@app.route('/pets', methods=['GET', 'POST'])
def pets():
    """Pets page"""
    if request.method == 'POST':
        # Get filter data from the request
        filters = request.get_json()

        # Filter pets based on species, status, and gender
        pets_query = Pet.query
        if filters.get('species'):
            pets_query = pets_query.filter(Pet.pet_type == filters['species'])
        if filters.get('status'):
            pets_query = pets_query.filter(Pet.pet_status == filters['status'])
        if filters.get('gender'):
            pets_query = pets_query.filter(Pet.gender == filters['gender'])

        # Retrieve filtered pets
        pets = pets_query.all()

        # Render the 'pets.html' template with updated pet data
        return render_template('blocks/pets_cards_filter.html', pets=pets)
    else:
        # Default GET request for initial page load
        pets = Pet.query.all()
        return render_template('pets.html', pets=pets, active_route='pets')

@app.route('/test', methods=['GET', 'POST'])
def test():
    """test login"""
    return render_template('petsn.html', active_route='home')

@app.route('/pets/<int:pet_id>')
def pet(pet_id):
    """pet page"""
    pet = Pet.query.get_or_404(pet_id)
    return render_template('pet.html', pet=pet, active_route='pets')

@app.route('/blogs')
def blogs():
    """blogs page"""
    blogs = Blog.query.all()
    return render_template('blogs.html', blogs=blogs, active_route='blogs')

@app.route('/blogs/<int:blog_id>')
def blog(blog_id):
    """blog page"""
    blog = Blog.query.get_or_404(blog_id)
    return render_template('blog.html', blog=blog, active_route='blogs')

@app.route('/medical', methods=['GET', 'POST'])
def medical():
    """Medical page"""
    medical_history = MedicalHistory.query.all()  # Fetch all medical history data
    pet_serials = {}  # Dictionary to store pet_id to serial mapping

    # Fetch serials for each pet_id in medical history
    if request.method == 'GET':
        for history in medical_history:
            pet_id = history.pet_id
            pet = Pet.query.filter_by(id=pet_id).first()
            if pet:
                pet_serials[pet_id] = pet.serial
        return render_template('medical.html', medical_history=medical_history, pet_serials=pet_serials , active_route='medical')

    if request.method == 'POST':
        serial = request.form['serial'].strip()  # Get the serial from the form submission, stripping leading/trailing spaces
        if not serial or serial.lower() == 'all':
            for history in medical_history:
                pet_id = history.pet_id
                pet = Pet.query.filter_by(id=pet_id).first()
                if pet:
                    pet_serials[pet_id] = pet.serial
            medical_table_html = render_template('blocks/medical_history.html', medical_history=medical_history, pet_serials=pet_serials)
            return jsonify({'medical_table_html': medical_table_html})

        pet = Pet.query.filter_by(serial=serial).first()  # Find the pet by serial
        if pet:
            medical_history = MedicalHistory.query.filter_by(pet_id=pet.id).all()
            pet_serials = {pet.id: pet.serial}
            medical_table_html = render_template('blocks/medical_history.html', medical_history=medical_history, pet_serials=pet_serials)
            return jsonify({'medical_table_html': medical_table_html})
        else:
            not_registered_html = "Unfinished or Pet serial number is not registered."
            medical_table_html = render_template('blocks/medical_history.html', medical_history=[], pet_serials={}, not_registered_html=not_registered_html)
            return jsonify({'medical_table_html': medical_table_html})

@app.route('/donate', methods=['GET', 'POST'])
def donate():
    """Donation page"""
    if request.method == 'POST':
        # Handle form submission for donation (dummy logic)
        payment_method = request.form.get('payment_method')
        # You can add logic here to handle donations based on the payment method selected

    # Render the donation template with a form to select a payment method
    return render_template('donate.html', active_route='donation')

@app.route('/shelter')
def shelter():
    """Shelter overview page"""
    # Update shelter overview data before displaying
    shelter_data = ShelterOverview.get_instance()
    shelter_data.update_totals()  # Update the shelter overview data
    # Fetch the updated shelter overview data
    shelter_data = shelter_data.serialize()
    return render_template('shelter.html', shelter=shelter_data, active_route='shelter')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['pwd']

        # Check if a user with the provided email exists in the database
        user = User.query.filter_by(email=email).first()

        if user and user.verify_password(password):
            # Set a session variable to identify that the user is logged in
            session['logged_in'] = True
            session['user_id'] = user.id
            session['user_name'] = user.username
            session['_role'] = user.role
            return redirect(url_for('home'))  # Redirect to the home page after successful login
        else:
            # If credentials are invalid, show an error message or redirect to the login page again
            return render_template('login.html', error='Invalid credentials. Please try again.')

    # Render the login template for GET requests
    return render_template('login.html')

@app.route('/logout')
def logout():
    # Remove the session variables to log out the user
    session.pop('logged_in', None)
    session.pop('user_id', None)
    session.pop('user_name', None)
    session.pop('_role', None)
    return redirect(url_for('home'))  # Redirect to the home page after logging out

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        firstname = request.form['firstname']
        lastname = request.form['lastname']
        username = request.form['username']
        email = request.form['email']
        password = request.form['pwd']
        role = 'client'  # Default role for a registered user
        # Check if the email is already in use
        existing_user = User.query.filter_by(email=email).first()
        if existing_user:
            return render_template('register.html', error='Email already in use. Please choose another.')
        # Create a new user instance and add it to the database
        new_user = User(firstname=firstname, lastname=lastname, username=username, email=email, password=password, role=role)
        db.session.add(new_user)
        db.session.commit()
        # Redirect to the login page after successful registration
        return redirect(url_for('home'))
    # Render the registration template for GET requests
    return render_template('register.html')

@app.route('/dashboard')
@login_required
def dashboard():
    """Dashboard page"""
    return render_template('dashboard.html')

@app.route('/profile', methods=['GET', 'POST'])
@login_required
def profile():
    """Profile page: Retrieve and update user data based on the session information"""
    user_id = session['user_id']
    user = User.query.get(user_id)

    if request.method == 'POST':
        # Retrieve updated information from the form
        new_firstname = request.form['firstname']
        new_lastname = request.form['lastname']
        new_email = request.form['email']
        new_password = request.form['password']
        confirm_password = request.form['confirm_password']
        # Check if the new password and confirm password fields match
        if new_password != confirm_password:
            flash('Passwords do not match!', 'danger')
            return redirect(url_for('profile'))

        # Update the user object with the new information
        user.firstname = new_firstname
        user.lastname = new_lastname
        user.email = new_email
        # Check if a new password is provided and update the password hash accordingly
        if new_password:
            user.password_hash = user._generate_password_hash(new_password)
        # Commit the changes to the database
        db.session.commit()
        flash('Profile updated successfully!', 'success')
        return redirect(url_for('profile'))

    # Render the profile template with the user's information for GET requests
    return render_template('profile.html', user=user)

@app.route('/mypets')
@login_required
def my_pets():
    """My Pets page: Logic to fetch and display the user's pets"""
    user_id = session['user_id']
    user_pets = Pet.query.filter_by(user_id=user_id).all()
    return render_template('mypets.html', user_pets=user_pets)

if __name__ == '__main__':
    app.run(debug=True)
