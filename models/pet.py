#!/usr/bin/python3
"""models pet"""
from .db import db
from datetime import datetime

class Pet(db.Model):
    """Pet model"""
    __tablename__ = 'allpets'
    id = db.Column(db.Integer, primary_key=True)
    serial = db.Column(db.String(100), unique=True, nullable=False)
    gender = db.Column(db.String(10), nullable=False)
    pet_type = db.Column(db.String(20), nullable=False)
    pet_status = db.Column(db.String(20))
    medical_history = db.Column(db.JSON)

    def __init__(self, gender, pet_type, pet_status, medical_history=None):
        """Pet model constructor"""
        self.serial = str(int(datetime.now().timestamp()))
        self.gender = gender
        self.pet_type = pet_type
        self.pet_status = pet_status
        self.medical_history = medical_history

    def serialize(self):
        """ Serialize object data to JSON if required"""
        return {
            'id': self.id,
            'serial': self.serial,
            'gender': self.gender,
            'pet_type': self.pet_type,
            'pet_status': self.pet_status,
            'medical_history': self.medical_history
        }
