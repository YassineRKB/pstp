#!/usr/bin/python3
"""models pet"""
from .db import db
from datetime import datetime

class Pet(db.Model):
    """Pet model"""
    __tablename__ = 'allpets'
    id = db.Column(db.Integer, primary_key=True)
    serial = db.Column(db.String(100), unique=True, nullable=False)
    pet_name = db.Column(db.String(100), nullable=False)
    gender = db.Column(db.String(10), nullable=False)
    pet_type = db.Column(db.String(20), nullable=False)
    pet_status = db.Column(db.String(20))
    background_story = db.Column(db.Text)
    medical_history = db.Column(db.JSON)
    created_at = db.Column(db.TIMESTAMP, default=datetime.utcnow)

    def __init__(self, pet_name, gender, pet_type, pet_status, background_story=None, medical_history=None):
        """Pet model constructor"""
        self.serial = str(int(datetime.timestamp(datetime.now())))
        self.pet_name = pet_name
        self.gender = gender
        self.pet_type = pet_type
        self.pet_status = pet_status
        self.background_story = background_story
        self.medical_history = medical_history

    def serialize(self):
        """ Serialize object data to JSON if required"""
        return {
            'id': self.id,
            'serial': self.serial,
            'pet_name': self.pet_name,
            'gender': self.gender,
            'pet_type': self.pet_type,
            'pet_status': self.pet_status,
            'background_story': self.background_story,
            'medical_history': self.medical_history,
            'created_at': self.created_at
        }
