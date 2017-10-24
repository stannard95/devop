#!/bin/bash

sudo apt-get update -y
sudo apt-get upgrade -y

# Gets the key for mnongo
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927

# Issue the following command to create a list file for MongoDB.
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

sudo apt-get update -y

# Install mongodb
sudo apt-get install mongodb-org -y

# Update mongod.conf file
sudo rm /etc/mongod.conf
sudo cp /home/ubuntu/environment/mongod.conf /etc/mongod.conf 

# Start up mongod
sudo systemctl enable mongod
sudo systemctl start mongod

sudo systemctl status mongod