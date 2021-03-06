from flask_restful import Resource, reqparse

from ..models.moomoobeenz import MooMooBeenz

mooMooBeenzParser = reqparse.RequestParser()
mooMooBeenzParser.add_argument('userId', required = True)
mooMooBeenzParser.add_argument('raterId', required = True)
mooMooBeenzParser.add_argument('mooMooBeenz', required = True)

class AddMooMooBeenz(Resource):
    # @jwt_refresh_token_required
    def post(self):
        # user = get_jwt_identity()
        #if user is None:
        #    return {'message': 'Invalid user'}
        data = mooMooBeenzParser.parse_args()
        mooMooBeenz = MooMooBeenz.get_user_moomoobeenz_for_rater(data['raterId'], data['userId'])
        if mooMooBeenz:
            mooMooBeenz.userId = data['userId'],
            mooMooBeenz.raterId = data['raterId'],
            mooMooBeenz.mooMooBeenz = data['mooMooBeenz']
        else:
            mooMooBeenz = MooMooBeenz(
            userId = data['userId'],
            raterId = data['raterId'],
            mooMooBeenz = data['mooMooBeenz']
            )

        try:
            mooMooBeenz.save()
            return {
                'message': 'UserId {} gives {} MooMooBeenz to UserId {}'
                    .format(mooMooBeenz.raterId, mooMooBeenz.mooMooBeenz, mooMooBeenz.userId)
            }, 200
        except Exception as e:
            return {'message': 'Error trying to assign MooMooBeenz' + str(e)}, 500

class AllMooMooBeenz(Resource):
    def get(self):
        return MooMooBeenz.get_all()