from flask import request, jsonify
from flask import Flask, render_template
from flask_restful import Api, Resource
from config import db_connection, api_key

app = Flask(__name__)
api = Api(app)
db = db_connection

print("Database opened successfully")
cur = db.cursor()


## DB get
headings = ("id", "firstname", "surname", "email")
@app.route('/get_user', methods=['GET'])
def getUser():
    headers = request.headers
    auth = headers.get("X-Api-Key")
    if auth != api_key:
        return jsonify({"message": "ERROR: Unauthorized"}), 401
    sql_query ="SELECT * FROM aotest.users order by id"
    cur.execute(sql_query)
    result = cur.fetchall()
    return jsonify(result)


if __name__ == '__main__':
    app.run(port=8080, debug=True)
