#!/usr/bin/python3
"""model client"""
from .db import db

class Client(db.Model):
    """model client"""
    __tablename__ = 'allclients'
    id = db.Column(db.Integer, primary_key=True)
    client_name = db.Column(db.String(100), nullable=False)
    client_email = db.Column(db.String(100), nullable=False)
    client_phone = db.Column(db.String(20), nullable=False)
    pet_serial = db.Column(db.String(100))  # If pet is registered
    pet_type = db.Column(db.String(20))  # 'cat' or 'dog'
    gender = db.Column(db.String(10))  # 'male' or 'female'
    checked_in_timestamp = db.Column(db.TIMESTAMP, nullable=False)

    def __init__(self, client_name, client_email, client_phone, pet_serial, pet_type, gender, checked_in_timestamp):
        """constructor"""
        self.client_name = client_name
        self.client_email = client_email
        self.client_phone = client_phone
        self.pet_serial = pet_serial
        self.pet_type = pet_type
        self.gender = gender
        self.checked_in_timestamp = checked_in_timestamp

    def serialize(self):
        """Serialize object data to JSON if required"""
        return {
            'id': self.id,
            'client_name': self.client_name,
            'client_email': self.client_email,
            'client_phone': self.client_phone,
            'pet_serial': self.pet_serial,
            'pet_type': self.pet_type,
            'gender': self.gender,
            'checked_in_timestamp': self.checked_in_timestamp
        }
