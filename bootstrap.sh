#!/usr/bin/env bash

# update apt-get
sudo apt-get update

# install various dependencies
sudo apt-get -y install build-essential
sudo apt-get -y install libreadline-gplv2-dev libncursesw5-dev libssl-dev
sudo apt-get -y install libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev
sudo apt-get -y install sshpass git-core sloccount

# setup www folder
rm -rf /var/www
ln -fs /vagrant /var/www




# Install Python
sudo apt-get -y install python2.7 python-pip python-dev libpq-dev
sudo pip install --upgrade pip

# Install code quality tools
sudo pip install pylint
sudo pip install mock
sudo pip install coverage
sudo pip install nose
sudo pip install nosexcover
sudo pip install clonedigger

# Install Flask Requirements
sudo pip install -r /var/www/requirements.txt

# Setup Discover-Flask
APP_SETTINGS="config.ProductionConfig"
export APP_SETTINGS
# sudo echo 'APP_SETTINGS=Production' >> /etc/environment

# Install SQLite3
sudo apt-get -y install sqlite3 libsqlite3-dev

# create folder for SQLite DB
cd /tmp
mkdir tmp
sudo chown www-data:www-data /tmp/tmp

# create DB tables, set folder and file permissions
cd /var/www/
python db_create_users.py
python db_create_posts.py
sudo chown www-data:www-data /tmp/tmp/sample.db
sudo chmod -R 777 /tmp/tmp




# Open port 80
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables-save

# install Apache, configure, start it
sudo apt-get -y install apache2
sudo apt-get -y install libapache2-mod-wsgi
sudo cp /var/www/discover-flask.conf /etc/apache2/sites-enabled/discover-flask.conf
sudo /etc/init.d/apache2 reload
# sudo rm -R /var/www/html
