#!/usr/bin/python3
"""models blog"""
from .db import db

class Blog(db.Model):
    """Blog model"""
    __tablename__ = 'allblogs'
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), nullable=False)
    body = db.Column(db.Text, nullable=False)
    short_description = db.Column(db.String(200))
    author = db.Column(db.String(100), nullable=False)

    def __init__(self, title, body, author):
        """Blog model constructor"""
        self.title = title
        self.body = body
        self.short_description = self.generate_short_description()
        self.author = author

    def generate_short_description(self):
        """Generate short description from the first 50 words of the body"""
        words = self.body.split()
        return ' '.join(words[:50]) if len(words) > 50 else self.body

    def update_blog(self, title, body, author):
        """Update blog info"""
        self.title = title
        self.body = body
        self.short_description = self.generate_short_description()
        self.author = author

    def serialize(self):
        """Serialize object data to JSON if required"""
        return {
            'id': self.id,
            'title': self.title,
            'body': self.body,
            'short_description': self.short_description,
            'author': self.author
        }
