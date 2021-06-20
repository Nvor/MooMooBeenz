from .. import db
from passlib.hash import pbkdf2_sha256 as sha256

class User(db.Model):
    __tablename__ = 'users'

    id = db.Column(db.Integer, primary_key = True)
    username = db.Column(db.String, unique = True, nullable = False)
    password = db.Column(db.String, nullable = False)
    firstname = db.Column(db.String, nullable = False)
    lastname = db.Column(db.String, nullable = False)
    summary = db.Column(db.String, nullable = True)
    picture = db.Column(db.String, nullable = True)

    def save(self):
        db.session.add(self)
        db.session.commit()

    def to_json(self):
        return {
            'id': self.id,
            'username': self.username,
            'firstname': self.firstname,
            'lastname': self.lastname,
            'summary': self.summary,
            'picture': self.picture
        }

    @classmethod
    def find_by_username(cls, username):
        return cls.query.filter_by(username=username).first()

    @classmethod
    def find_by_id(cls, id):
        return cls.query.filter_by(id = id).first()

    @classmethod
    def get_all(cls):
        def to_json(x):
            return {
                'id': x.id,
                'username': x.username,
                'password': x.password,
                'firstname': x.firstname,
                'lastname': x.lastname,
                'summary': x.summary
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