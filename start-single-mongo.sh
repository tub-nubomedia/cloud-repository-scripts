#!/bin/bash

if [ -z ${PORT+x} ]; then 
  echo "PORT is unset";
  PORT=27018
else 
  echo "PORT is set to '$PORT'"; 
fi

if [ -z ${SECURITY+x} ]; then 
  echo "SECURITY is unset";
  SECURITY="false"
else 
  echo "SECURITY is set to '$SECURITY'";
fi

function kill {
    if screen -list | grep "mongodb"; then
        screen -ls | grep mongodb | cut -d. -f1 | awk '{print $1}' | xargs kill
    fi
}

mkdir /home/ubuntu/data
export LC_ALL=C

if [ $SMALLFILES = 'true' ]
then
	screen -d -m -S mongodb mongod --smallfiles --port $PORT --dbpath /home/ubuntu/data
else
	screen -d -m -S mongodb mongod --port $PORT --dbpath /home/ubuntu/data
fi

while ! nc -z localhost $PORT; do
  sleep 0.5 # wait for 1/10 of the second before check again
done


if [ $SECURITY = 'true' ]
then
  
  if [ -z ${USERNAME_MD+x} ]; then
    echo "USERNAME_MD needs to be set if SECURITY is set to true"
    exit 99
  fi
  if [ -z ${PASSWORD+x} ]; then
    echo "PASSWORD needs to be set if SECURITY is set to true"
    exit 98
  fi

  echo "use admin" >> addUser.js
  echo "db.createUser( { user: '`echo $USERNAME_MD`', pwd: '`echo $PASSWORD`', roles: [ 'userAdminAnyDatabase' ] } )" >> addUser.js

  cat addUser.js

  mongo --port $PORT < addUser.js

  kill

  sleep 3

  if [ $SMALLFILES = 'true' ]
  then
  	echo "executing screen"
  	screen -d -m -S mongodb mongod --smallfiles --port $PORT --dbpath /home/ubuntu/data --auth
  else
  	screen -d -m -S mongodb mongod --port $PORT --dbpath /home/ubuntu/data --auth
  fi
fi

COUNTER=0

while ! nc -z localhost $PORT; do
	echo "it's been $COUNTER seconds and it is not started yet..."
	let COUNTER=COUNTER+1
  	sleep 1 # wait for 1 second before check again
  	if [ $COUNTER -gt 120 ]; then
  		exit 2
  	fi
done