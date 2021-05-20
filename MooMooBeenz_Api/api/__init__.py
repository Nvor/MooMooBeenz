from flask import Flask
from flask_restful import Api, Resource
from flask_sqlalchemy import SQLAlchemy
from flask_jwt_extended import JWTManager

db = SQLAlchemy()

from . import views, models, resources

def create_app(config_name):
    app = Flask(__name__)

    app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///database.db'
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    app.config['SECRET_KEY'] = 'some-secret-string'
    app.config['JWT_SECRET_KEY'] = 'jwt-secret-string'
    app.config['JWT_BLACKLIST_ENABLED'] = True
    app.config['JWT_BLACKLIST_TOKEN_CHECKS'] = ['access','refresh']

    api = Api(app)

    api.add_resource(resources.UserRegistration, '/registration')
    api.add_resource(resources.UserLogin, '/login')
    api.add_resource(resources.UserLogoutAccess, '/logout/access')
    api.add_resource(resources.UserLogoutRefresh, '/logout/refresh')
    api.add_resource(resources.TokenRefresh, '/token/refresh')
    api.add_resource(resources.AllUsers, '/users')
    api.add_resource(resources.User, '/user')
    api.add_resource(resources.AddMooMooBeenz, '/moomoobeenz/add')
    api.add_resource(resources.AllMooMooBeenz, '/moomoobeenz')

    db.init_app(app)

    jwt = JWTManager(app)

    @app.before_first_request
    def create_tables():
        db.create_all()

    @jwt.token_in_blacklist_loader
    def verify_if_token_in_blacklist(token_to_verify):
        token = token_to_verify['token']
        return models.RevokedToken.IsTokenRevoked(token)

    return app