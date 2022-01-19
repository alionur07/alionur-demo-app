import psycopg2
from flask import Flask
import config

app = Flask(__name__)
CONFIG = {
    'postgresHost': 'ChangeMe',
    'postgresPort': '5432',
    'postgresUser': 'postgres',
    'postgresPass': 'changeME',
    'postgresDb': 'postgres',
    'api_key': 'esdpLwTdf6zP3BWrAth8ns'
}

api_key = config.CONFIG['api_key']
postgres_host = config.CONFIG['postgresHost']
postgres_port = config.CONFIG['postgresPort']
postgres_user = config.CONFIG['postgresUser']
postgres_pass = config.CONFIG['postgresPass']
postgres_db = config.CONFIG['postgresDb']
db_connection = psycopg2.connect("dbname='%s' user='%s' host='%s' password='%s' port='%s' " % (postgres_db, postgres_user, postgres_host, postgres_pass, postgres_port ))

