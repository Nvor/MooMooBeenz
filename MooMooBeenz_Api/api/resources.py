from flask_restful import Resource, reqparse
from flask_jwt_extended import create_access_token, create_refresh_token, jwt_required, jwt_refresh_token_required, get_jwt_identity, get_raw_jwt

from .models import User, RevokedToken

parser = reqparse.RequestParser()
parser.add_argument('username', required = True)
parser.add_argument('password', required = True)

class UserRegistration(Resource):
    def post(self):
        data = parser.parse_args()

        if User.find_by_username(data['username']):
            return {
                'message': 'User {} already exists'.format(data['username'])
            }

        user = User(
            username = data['username'],
            password = User.generate_hash(data['password'])
        )
        try:
            user.save()
            access_token = create_access_token(identity = data['username'])
            refresh_token = create_refresh_token(identity = data['username'])
            return {
                'message': 'User {} was created'.format(data['username']),
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
        data = parser.parse_args()
        user = User.find_by_username(data['username'])

        if not user:
            return {'message': 'User {} does not exist'.format(data['username'])}

        if User.verify_hash(data['password'], user.password):
            access_token = create_access_token(identity = data['username'])
            refresh_token = create_refresh_token(identity = data['username'])
            return {
                'message': 'Logged in: {}'.format(user.username),
                'access_token': access_token,
                'refresh_token': refresh_token
            }
        else:
            return {'message': 'Incorrect password'}

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