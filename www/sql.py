# sql.py - Create a SQLite3 table and populate it with data
import sqlite3

# create a new database if the database doesn't already exist
with sqlite3.connect('sample.db') as connection:

    # get a cursor object used to execute SQL commands
    c = connection.cursor()

    # create the table
    # c.execute('DROP TABLE posts')
    c.execute('CREATE TABLE posts(title TEXT, description TEXT)')

    # insert dummy data into the table
    c.execute('INSERT INTO posts VALUES("Good", "I\'m good.")')
    c.execute('INSERT INTO posts VALUES("Well", "I\'m well.")')
    c.execute('INSERT INTO posts VALUES("Excellent", "I\'m excellent.")')
    c.execute('INSERT INTO posts VALUES("Okay", "I\'m okay.")')

    # create the table
    # c.execute('DROP TABLE users')
    c.execute('CREATE TABLE users(id INT PRIMARY KEY, name TEXT NOT NULL, email TEXT NOT NULL, password TEXT)')

    # insert dummy data into the table
    c.execute('INSERT INTO users VALUES(1, "admin2", "ad@min.com", "admin2")')
