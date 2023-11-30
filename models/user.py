#!/usr/bin/python3
"""models user"""
from .db import db
from hashlib import sha256

class User(db.Model):
    """User class"""
    __tablename__ = 'allusers'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(50), unique=True, nullable=False)
    email = db.Column(db.String(100), unique=True, nullable=False)
    password_hash = db.Column(db.String(64), nullable=False)
    role = db.Column(db.String(20), nullable=False)  # 'worker', 'client', 'admin'

    def __init__(self, username, email, password, role):
        """constructor"""
        self.username = username
        self.email = email
        self.password_hash = self._generate_password_hash(password)
        self.role = role

    def _generate_password_hash(self, password):
        """generate password hash"""
        return sha256(password.encode()).hexdigest()  # Storing password hash instead of plain text

    def verify_password(self, password):
        """verify password"""
        return self.password_hash == sha256(password.encode()).hexdigest()

    def serialize(self):
        """serialize"""
        return {
            'id': self.id,
            'username': self.username,
            'email': self.email,
            'role': self.role
        }
