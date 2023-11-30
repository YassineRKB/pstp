#!/usr/bin/python3
"""models food.py"""
from .db import db

class Food(db.Model):
    """food model"""
    __tablename__ = 'allfood'
    id = db.Column(db.Integer, primary_key=True)
    food_name = db.Column(db.String(100), nullable=False)
    food_stock = db.Column(db.Integer, nullable=False)
    food_type = db.Column(db.String(20), nullable=False)  # 'cat' or 'dog'
    food_expiry_date = db.Column(db.Date)

    def __init__(self, food_name, food_stock, food_type, food_expiry_date=None):
        """constructor"""
        self.food_name = food_name
        self.food_stock = food_stock
        self.food_type = food_type
        self.food_expiry_date = food_expiry_date

    @classmethod
    def create(cls, food_name, food_stock, food_type, food_expiry_date=None):
        """Create a new food"""
        new_food = cls(food_name=food_name, food_stock=food_stock, food_type=food_type, food_expiry_date=food_expiry_date)
        db.session.add(new_food)
        db.session.commit()
        return new_food

    def update(self, food_name, food_stock, food_type, food_expiry_date=None):
        """Update food info"""
        self.food_name = food_name
        self.food_stock = food_stock
        self.food_type = food_type
        self.food_expiry_date = food_expiry_date
        db.session.commit()

    def delete(self):
        """Delete food"""
        db.session.delete(self)
        db.session.commit()

    def serialize(self):
        """ Serialize object data to JSON if required"""
        return {
            'id': self.id,
            'food_name': self.food_name,
            'food_stock': self.food_stock,
            'food_type': self.food_type,
            'food_expiry_date': str(self.food_expiry_date) if self.food_expiry_date else None
        }

