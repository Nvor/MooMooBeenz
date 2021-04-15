from . import db
from passlib.hash import pbkdf2_sha256 as sha256

class User(db.Model):
    __tablename__ = 'users'

    id = db.Column(db.Integer, primary_key = True)
    username = db.Column(db.String, unique = True, nullable = False)
    password = db.Column(db.String, nullable = False)
    firstname = db.Column(db.String, nullable = False)
    lastname = db.Column(db.String, nullable = False)
    picture = db.Column(db.String)

    def save(self):
        db.session.add(self)
        db.session.commit()

    @classmethod
    def find_by_username(cls, username):
        return cls.query.filter_by(username=username).first()

    @classmethod
    def get_all(cls):
        def to_json(x):
            return {
                'username': x.username,
                'password': x.password
            }
        return {'users': [to_json(user) for user in User.query.all()]}

    @classmethod
    def delete_all(cls):
        try:
            db.session.query(cls).delete()
            db.session.commit()
            return {'message': 'All records deleted'}
        except:
            return {'message': 'Failed to delete all users'}

    @staticmethod
    def generate_hash(password):
        return sha256.hash(password)

    @staticmethod
    def verify_hash(password, hash):
        return sha256.verify(password, hash)

class MooMooBeenz(db.Model):
    __tablename__ = 'UserMooMooBeenz'
    id = db.Column(db.Integer, primary_key = True)
    userId = db.Column(db.Integer, nullable = False)
    raterId = db.Column(db.Integer, nullable = False)
    MooMooBeenz = db.Column(db.Integer, nullable = False)

    def save(self):
        db.session.add(self)
        db.session.commit()

    @classmethod
    def get_user_moomoobeenz_for_rater(cls, raterId, userId):
        return cls.query.filter_by(
            raterId=raterId,
            userId=userId
        ).first()

class RevokedToken(db.Model):
    __tablename__ = 'RevokedTokens'
    id = db.Column(db.Integer, primary_key = True)
    token = db.Column(db.String(100))

    def add(self):
        db.session.add(self)
        db.session.commit()

    @classmethod
    def IsTokenRevoked(cls, token):
        result = cls.query.filter_by(token=token).first()
        return bool(result)