from flask_restful import Resource, reqparse
from flask_jwt_extended import create_access_token, create_refresh_token, jwt_required, jwt_refresh_token_required, get_jwt_identity, get_raw_jwt

from .models import User, RevokedToken, MooMooBeenz

userParser = reqparse.RequestParser()
userParser.add_argument('username', required = True)
userParser.add_argument('password', required = True)

userDataParser = reqparse.RequestParser()
userDataParser.add_argument('id', required = True)
userDataParser.add_argument('username', required = True)
userDataParser.add_argument('firstname', required = True)
userDataParser.add_argument('lastname', required = True)
userDataParser.add_argument('summary', required = False)
userDataParser.add_argument('picture', required = False)

mooMooBeenzParser = reqparse.RequestParser()
mooMooBeenzParser.add_argument('userId', required = True)
mooMooBeenzParser.add_argument('raterId', required = True)
mooMooBeenzParser.add_argument('mooMooBeenz', required = True)

class UserRegistration(Resource):
    urParser = userParser.copy()
    urParser.add_argument('firstname', required = True)
    urParser.add_argument('lastname', required = True)
    urParser.add_argument('summary', required = False)
    urParser.add_argument('picture', required = False)

    def post(self):
        data = self.urParser.parse_args()

        if User.find_by_username(data['username']):
            return {
                'message': 'User {} already exists'.format(data['username'])
            }, 400

        user = User(
            username = data['username'],
            password = User.generate_hash(data['password']),
            firstname = data['firstname'],
            lastname = data['lastname'],
            summary = data['summary'],
            picture = data['picture']
        )
        try:
            user.save()
            access_token = create_access_token(identity = data['username'])
            refresh_token = create_refresh_token(identity = data['username'])
            return {
                'message': 'User {} was created'.format(data['username']),
                'user': user.to_json(),
                'access_token': access_token,
                'refresh_token': refresh_token
            }
        except:
            return {
                'message': 'Failed to register user'
            }, 500
        return data

class UserLogin(Resource):
    def post(self):
        data = userParser.parse_args()
        user = User.find_by_username(data['username'])

        if not user:
            return {'message': 'User {} does not exist'.format(data['username'])}, 400

        if User.verify_hash(data['password'], user.password):
            access_token = create_access_token(identity = data['username'])
            refresh_token = create_refresh_token(identity = data['username'])
            return {
                'message': 'Logged in: {} (UserId {})'.format(user.username, user.id),
                'user': user.to_json(),
                'access_token': access_token,
                'refresh_token': refresh_token
            }
        else:
            return {'message': 'Incorrect password'}, 400

class UserLogoutAccess(Resource):
    @jwt_required
    def post(self):
        token = get_raw_jwt()['token']
        try:
            revoked_token = RevokedToken(token=token)
            revoked_token.add()
            return {'message': 'Access token revoked'}
        except:
            return {'message': 'Failed to revoke token'}, 500
      
      
class UserLogoutRefresh(Resource):
    @jwt_refresh_token_required
    def post(self):
        token = get_raw_jwt()['token']
        try:
            revoked_token = RevokedToken(token=token)
            revoked_token.add()
            return {'message': 'Refresh token revoked'}
        except:
            return {'message': 'Failed to revoke token'}, 500
      
class TokenRefresh(Resource):
    @jwt_refresh_token_required
    def post(self):
        user = get_jwt_identity()
        access_token = create_access_token(identity = user)
        return {'access_token': access_token}
      
class AllUsers(Resource):
    def get(self):
        return User.get_all()

    def delete(self):
        return User.delete_all()

class UserData(Resource):
    udParser = userDataParser.copy()

    def get(self):
        data = self.udParser.parse_args()
        return User.find_by_id(data['id'])

    def post(self):
        data = self.udParser.parse_args()
        if User.find_by_id(data['id']):
            userSave = User(
                id = data['id'],
                username = data['username'],
                firstname = data['firstname'],
                lastname = data['lastname'],
                summary = data['summary'],
                picture = data['picture']
            )
            try:
                userSave.save()
                return {'user': userSave.to_json()}, 200
            except:
                return {'message': 'Error trying to save user data'}, 500
        else:
            return {'message': 'Invalid user id provided'}, 400

class AddMooMooBeenz(Resource):
    # @jwt_refresh_token_required
    def post(self):
        # user = get_jwt_identity()
        #if user is None:
        #    return {'message': 'Invalid user'}
        data = mooMooBeenzParser.parse_args()
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
        except:
            return {'message': 'Error trying to assign MooMooBeenz'}, 500

class AllMooMooBeenz(Resource):
    def get(self):
        return MooMooBeenz.get_all()