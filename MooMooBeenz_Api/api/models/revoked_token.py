from .. import db

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