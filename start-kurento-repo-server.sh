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

KURENTO_CONFIG_FILE="/opt/kurento-repository-server-6.4.0/config/kurento-repo.conf.json"

if [ -z ${PORT+x} ]; then 
  echo "PORT is unset";
  PORT=27018
else 
  echo "PORT is set to '$PORT'"; 
fi


if [[ $SECURITY = "true" ]]; then
	sudo sed -i -e "s/127.0.0.1/$internal_nubomedia_floatingIp/g" -e "s/localhost/$USERNAME_MD:$PASSWORD@localhost:$PORT/g" $KURENTO_CONFIG_FILE
else
	sudo sed -i -e "s/127.0.0.1/$internal_nubomedia_floatingIp/g" -e "s/localhost/localhost:$PORT/g" $KURENTO_CONFIG_FILE
fi


# java bug for secure random generation
sudo sed -i -e 's/securerandom.source=file:\/dev\/urandom/securerandom.source=file:\/dev\/.\/urandom/g'  /usr/lib/jvm/java-7-openjdk-amd64/jre/lib/security/java.security

cd /opt/kurento-repository-server-6.4.0
screen -d -m -S kurento-repo-server bin/start.sh
