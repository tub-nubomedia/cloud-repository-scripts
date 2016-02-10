#!/bin/bash

# Copyright (c) 2015 Technische Universität Berlin
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10

echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list

sudo apt-get update
sudo apt-get install -y mongodb-org screen unzip openjdk-7-jre

sudo service mongod stop

# cd /opt
# sudo wget http://builds.kurento.org/release/stable/kurento-repository-server.zip

# unzip kurento-repository-server.zip
# cd kurento-repository-server-6.3.0

# bin/install.sh
/etc/init.d/kurento-repo stop
