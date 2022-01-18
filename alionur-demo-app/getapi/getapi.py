from flask import request, jsonify
from flask import Flask, render_template
from flask_restful import Api, Resource
from config import db_connection, api_key
from prometheus_flask_exporter import PrometheusMetrics

app = Flask(__name__)
api = Api(app)
db = db_connection

print("Database opened successfully")
cur = db.cursor()

# static information as metric
metrics = PrometheusMetrics(app)
metrics.info('app_info', 'Application info', version='1.0.3')
@app.route('/metrics')
def main():
    pass  # requests tracked by default

## DB get
headings = ("id", "firstname", "surname", "email")
@app.route('/get_user', methods=['GET'])
def getUser():
    headers = request.headers
    auth = headers.get("X-Api-Key")
    if auth != api_key:
        return jsonify({"message": "ERROR: Unauthorized"}), 401
    sql_query ="SELECT * FROM users order by id"
    cur.execute(sql_query)
    result = cur.fetchall()
    return jsonify(result)


if __name__ == '__main__':
    app.run(host="0.0.0.0",port=8080, debug=False)
