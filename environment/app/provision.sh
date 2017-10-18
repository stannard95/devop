#!/bin/bash

# update the sources list and upgrades any existing packages
sudo apt-get update -y
sudo apt-get upgrade -y

# install nginx
sudo apt-get install nginx -y

# Specifies the latest verison of node
curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh

# Sets up node source
sudo bash nodesource_setup.sh

# Installs node
sudo apt-get install -y nodejs

# Installs mp2 using npm
sudo npm install pm2 -g