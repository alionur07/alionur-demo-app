from flask import request
from flask import Flask, render_template
from flask_restful import Api, Resource
from config import db_connection, api_key

app = Flask(__name__)
api = Api(app)
db = db_connection

print("Database opened successfully")
cur = db.cursor()


## DB insert
@app.route('/insert_user', methods=['POST'])
def insertUser():
    headers = request.headers
    auth = headers.get("X-Api-Key")
    if auth != api_key:
        return jsonify({"message": "ERROR: Unauthorized"}), 401
    newFirstName = request.form['firstname']
    newSurName = request.form['surname']
    newEmail = request.form['email']
    cur.execute("INSERT INTO aotest.users (firstname, surname, email) VALUES (%s, %s, %s)",
                (newFirstName, newSurName, newEmail));
    db.commit()
    return "Data inserted successfully "

if __name__ == '__main__':
    app.run(port=8080, debug=True)
