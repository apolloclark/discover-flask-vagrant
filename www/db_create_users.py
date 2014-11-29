from project import db
from project.models import User

# create the database and the db table
db.create_all()

# insert data
db.session.add(User("michael", "michael@realpython.com", "i'll-never-tell"))
db.session.add(User("admin", "ad@min.com", "admin"))
db.session.add(User("mike", "mike@herman.com", "tell"))

# commit the changes
db.session.commit()
