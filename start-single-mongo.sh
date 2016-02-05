#!/bin/bash

function kill {
    if screen -list | grep "mongodb"; then
        screen -ls | grep mongodb | cut -d. -f1 | awk '{print $1}' | xargs kill
    fi
}

mkdir /home/ubuntu/data
export LC_ALL=C

if [ $smallfiles = 'true' ]
then
	screen -d -m -S mongodb mongod --smallfiles --port 27018 --dbpath /home/ubuntu/data
else
	screen -d -m -S mongodb mongod --port 27018 --dbpath /home/ubuntu/data
fi

while ! nc -z localhost 27018; do
  sleep 0.5 # wait for 1/10 of the second before check again
done

echo "use admin" >> addUser.js
echo "db.createUser( { user: '`echo $USERNAME_MD`', pwd: '`echo $PASSWORD`', roles: [ 'userAdminAnyDatabase' ] } )" >> addUser.js

cat addUser.js

mongo --port 27018 < addUser.js

kill

sleep 3

if [ $smallfiles = 'true' ]
then
	echo "executing screen"
	screen -d -m -S mongodb mongod --smallfiles --port 27018 --dbpath /home/ubuntu/data --auth
else
	screen -d -m -S mongodb mongod --port 27018 --dbpath /home/ubuntu/data --auth
fi

COUNTER=0

while ! nc -z localhost 27018; do
	echo "it's been $COUNTER seconds and it is not started yet..."
	let COUNTER=COUNTER+1
  	sleep 1 # wait for 1 second before check again
  	if [ $COUNTER -gt 120 ]; then
  		exit 2
  	fi
done