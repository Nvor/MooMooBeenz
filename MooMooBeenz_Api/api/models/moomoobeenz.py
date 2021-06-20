from .. import db

class MooMooBeenz(db.Model):
    __tablename__ = 'MooMooBeenz'
    
    id = db.Column(db.Integer, primary_key = True)
    userId = db.Column(db.Integer, nullable = False)
    raterId = db.Column(db.Integer, nullable = False)
    mooMooBeenz = db.Column(db.Integer, nullable = False)

    def save(self):
        db.session.add(self)
        db.session.commit()

    @classmethod
    def get_user_moomoobeenz_for_rater(cls, raterId, userId):
        return cls.query.filter_by(
            raterId=raterId,
            userId=userId
        ).first()

    @classmethod
    def get_all(cls):
        def to_json(x):
            return {
                'id': x.id,
                'userId': x.userId,
                'raterId': x.raterId,
                'MooMooBeenz': x.mooMooBeenz
            }
        return {'MooMooBeenz': [to_json(mooMooBeenz) for mooMooBeenz in MooMooBeenz.query.all()]}