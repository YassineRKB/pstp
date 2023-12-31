#!/usr/bin/python3
"""models medical history"""
from .db import db
from datetime import datetime

class MedicalHistory(db.Model):
    """Medical history class"""
    __tablename__ = 'medic_history'
    id = db.Column(db.Integer, primary_key=True)
    pet_id = db.Column(db.Integer, db.ForeignKey('allpets.id'), nullable=False)
    checkup_timestamp = db.Column(db.TIMESTAMP, nullable=False)
    checkup_summary = db.Column(db.Text)

    def __init__(self, pet_id, checkup_timestamp, checkup_summary=None):
        """Constructor"""
        self.pet_id = pet_id
        self.checkup_timestamp = checkup_timestamp
        self.checkup_summary = checkup_summary

    @classmethod
    def create(cls, pet_id, checkup_timestamp, checkup_summary=None):
        """Create a new medical history entry"""
        new_medical_history = cls(pet_id=pet_id, checkup_timestamp=checkup_timestamp, checkup_summary=checkup_summary)
        db.session.add(new_medical_history)
        db.session.commit()
        return new_medical_history

    def serialize(self):
        """Serialize object data to JSON if required"""
        return {
            'id': self.id,
            'pet_id': self.pet_id,
            'checkup_timestamp': self.checkup_timestamp,
            'checkup_summary': self.checkup_summary
        }
