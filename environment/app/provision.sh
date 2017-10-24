#!/bin/bash

# update the sources list and upgrades any existing packages
sudo apt-get update -y
sudo apt-get upgrade -y

# install nginx
sudo apt-get install nginx -y

sudo apt-get update -y

# Specifies the latest verison of node
curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh

# Sets up node source
sudo bash nodesource_setup.sh

# Installs node
sudo apt-get install -y nodejs

# Installs mp2 us
sudo npm install pm2 -g

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927

# Issue the following command to create a list file for MongoDB.
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

sudo apt-get update -y

# Install mongodb
sudo apt-get install -y mongodb-org
sudo apt-get install mongodb-clients

# add app user and group
sudo adduser --disabled-password --gecos app
sudo chown -R app:app app /home/ubuntu/app

# Setup reverse proxy
sudo rm /etc/nginx/sites-available/default

sudo cp /home/ubuntu/devop/environment/app/reverse-proxy.conf /etc/nginx/sites-available

sudo cp /home/ubuntu/environment/app/reverse-proxy.conf /etc/nginx/sites-available

sudo ln -s /etc/nginx/sites-available/reverse-proxy.conf /etc/nginx/sites-enabled/reverse-proxy.conf
sudo service nginx configtest
sudo service nginx restart

