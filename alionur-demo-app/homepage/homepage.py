import json
import urllib

import requests as requests
from flask import request
from flask import Flask, render_template
from flask_restful import Api, Resource
from config import db_connection, api_key
from prometheus_flask_exporter import PrometheusMetrics

app = Flask(__name__)
api = Api(app)

metrics = PrometheusMetrics(app)
# static information as metric
metrics.info('app_info', 'Application info', version='1.0.3')
@app.route('/metrics')
def main():
    pass  # requests tracked by default

## Homepage
headings = ("id", "firstname", "surname", "email", "date")
@app.route('/')
def table():
    response = requests.get("http://getapi.default:8080/get_user", headers={"X-Api-Key": api_key})
    result = response.json()
    return render_template ("home_page.html", data=result, headings=headings)


if __name__ == '__main__':
    app.run(host="0.0.0.0",port=8080, debug=False)