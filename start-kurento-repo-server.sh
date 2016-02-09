#!/bin/bash

if [ -z ${PORT+x} ]; then 
  echo "PORT is unset";
  PORT=27018
else 
  echo "PORT is set to '$PORT'"; 
fi


if [[ $SECURITY = "true" ]]; then
	sudo sed -i -e "s/127.0.0.1/$internal_nubomedia_floatingIp/g" -e "s/localhost/$USERNAME_MD:$PASSWORD@localhost:$PORT/g" /etc/kurento/kurento-repo.conf.json
else
	sudo sed -i -e "s/127.0.0.1/$internal_nubomedia_floatingIp/g" -e "s/localhost/localhost:$PORT/g" /etc/kurento/kurento-repo.conf.json
fi


# java bug for secure random generation
sudo sed -i -e 's/securerandom.source=file:\/dev\/urandom/securerandom.source=file:\/dev\/.\/urandom/g'  /usr/lib/jvm/java-7-openjdk-amd64/jre/lib/security/java.security

cd /opt/kurento-repository-server-6.3.0
screen -d -m -S kurento-repo-server bin/start.sh
