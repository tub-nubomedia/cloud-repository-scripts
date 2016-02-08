#!/bin/bash

sudo sed -i -e "s/127.0.0.1/$internal_nubomedia_floatingIp/g" /etc/kurento/kurento-repo.conf.json

cd /opt/kurento-repository-server-6.3.0
screen -d -m -S kurento-repo-server bin/start.sh
