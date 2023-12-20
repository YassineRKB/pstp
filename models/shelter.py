from .db import db
from .pet import Pet
from .client import Client
from .food import Food
from .medical_history import MedicalHistory
from .user import User
from .blog import Blog

class ShelterOverview(db.Model):
    """Shelter overview model"""
    __tablename__ = 'shelter_overview'
    id = db.Column(db.Integer, primary_key=True)
    total_regi_pets = db.Column(db.Integer, default=0)
    total_food = db.Column(db.Integer, default=0)
    total_checkup = db.Column(db.Integer, default=0)
    total_clients = db.Column(db.Integer, default=0)
    total_users = db.Column(db.Integer, default=0)
    total_blogs = db.Column(db.Integer, default=0)

    @classmethod
    def get_instance(cls):
        """Get shelter overview instance"""
        shelter_overview = cls.query.first()
        if shelter_overview is None:
            shelter_overview = cls()
            db.session.add(shelter_overview)
            db.session.commit()
        return shelter_overview

    def update_totals(self):
        """Update the shelter overview data"""
        self.total_regi_pets = Pet.query.count()
        self.total_food = Food.query.count()
        self.total_checkup = MedicalHistory.query.count()
        self.total_clients = Client.query.count()
        self.total_users = User.query.count()
        self.total_blogs = Blog.query.count()
        db.session.commit()

    def serialize(self):
        """Serialize shelter overview data"""
        return {
            'id': self.id,
            'total_regi_pets': self.total_regi_pets,
            'total_food': self.total_food,
            'total_checkup': self.total_checkup,
            'total_clients': self.total_clients,
            'total_users': self.total_users,
            'total_blogs': self.total_blogs
        }
