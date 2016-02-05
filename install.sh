#!/bin/bash

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10

echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list

sudo apt-get update
sudo apt-get install -y mongodb-org screen unzip openjdk-7-jre

sudo service mongod stop

cd /opt
sudo wget http://builds.kurento.org/release/stable/kurento-repository-server.zip

unzip kurento-repository-server.zip
cd kurento-repository-server

bin/install.sh
