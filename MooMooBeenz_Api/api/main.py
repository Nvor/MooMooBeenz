from flask import Flask
from flask_restful import Api, Resource
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
api = Api(app)

class TestApi(Resource):
    def get(self):
        return {"Message":"Hello World"}

api.add_resource(TestApi, "/TestApi")

if __name__ == '__main__':
    app.run(debug=True)