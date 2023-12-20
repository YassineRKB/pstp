from flask import Blueprint, jsonify, request, abort
from models import Pet, Blog, MedicalHistory, ShelterOverview

v1_blueprint = Blueprint("v1", __name__)

# endpoints
@v1_blueprint.route('/', methods=['GET'])
def api_get_ans():
    """root endpoint API"""
    serialized_ans = [
        "Welcome to the Pet API v1",
        "Please use the following endpoints to access the data", "pets", "blogs", "medical", "shelter"
        ]
    return jsonify(serialized_ans)

@v1_blueprint.route('/pets', methods=['GET', 'POST'])
def api_pets():
    """Pets page API"""
    if request.method == 'POST':
        filters = request.get_json()
        pets_query = Pet.query
        if filters.get('species'):
            pets_query = pets_query.filter(Pet.pet_type == filters['species'])
        if filters.get('status'):
            pets_query = pets_query.filter(Pet.pet_status == filters['status'])
        if filters.get('gender'):
            pets_query = pets_query.filter(Pet.gender == filters['gender'])
        pets = pets_query.all()
        serialized_pets = [pet.serialize() for pet in pets]
        response = {
            'filtered_pets': serialized_pets
        }
        return jsonify(response)
    else:
        pets = Pet.query.all()
        serialized_pets = [pet.serialize() for pet in pets]
        response = {
            'pets': serialized_pets
        }
        return jsonify(response)

@v1_blueprint.route('/pets/<int:pet_id>', methods=['GET'])
def api_get_pet(pet_id):
    """Get pet by ID API"""
    pet = Pet.query.get(pet_id)
    if not pet:
        """Return 404 if pet with given ID is not found"""
        abort(404)
    serialized_pet = pet.serialize()
    return jsonify(serialized_pet)

@v1_blueprint.route('/blogs', methods=['GET'])
def api_get_blogs():
    """Get all blogs API"""
    blogs = Blog.query.all()
    serialized_blogs = [blog.serialize() for blog in blogs]
    return jsonify(serialized_blogs)

@v1_blueprint.route('/blogs/<int:blog_id>', methods=['GET'])
def api_get_blog(blog_id):
    """Get blog by ID API"""
    blog = Blog.query.get(blog_id)
    if not blog:
        abort(404)  # Return 404 if blog with given ID is not found
    serialized_blog = blog.serialize()
    return jsonify(serialized_blog)

@v1_blueprint.route('/medical', methods=['GET'])
def api_get_medical_history():
    """Get all medical history API"""
    medical_history = MedicalHistory.query.all()
    serialized_medical_history = [history.serialize() for history in medical_history]
    return jsonify(serialized_medical_history)

@v1_blueprint.route('/medical/<int:medical_id>', methods=['GET'])
def api_get_medical_history_by_id(medical_id):
    """Get medical history by ID API"""
    medical_record = MedicalHistory.query.get(medical_id)
    if not medical_record:
        abort(404)  # Return 404 if medical record with given ID is not found
    serialized_medical_record = medical_record.serialize()
    return jsonify(serialized_medical_record)

@v1_blueprint.route('/shelter', methods=['GET'])
def api_get_shelter_overview():
    """Get shelter overview API"""
    shelter_data = ShelterOverview.get_instance()
    shelter_data.update_totals()  # Update the shelter overview data
    serialized_shelter_data = shelter_data.serialize()
    return jsonify(serialized_shelter_data)


if __name__ == '__main__':
    v1_blueprint.run(debug=True)
