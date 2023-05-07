import os
from dotenv import load_dotenv
from flask_script import Manager
from flask_migrate import Migrate, MigrateCommand

import pymysql
pymysql.install_as_MySQLdb()


dotenv_path = os.path.join(os.path.dirname(__file__), '.env')
if os.path.exists(dotenv_path):
    load_dotenv(dotenv_path,override=True)

from app import create_app
from app.extensions import db

app = create_app()
manager = Manager(app)
Migrate(app, db)
manager.add_command("db", MigrateCommand)


if __name__ == "__main__":
    manager.run()


