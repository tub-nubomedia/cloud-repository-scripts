#!/bin/bash

export LC_ALL=C

mkdir -p ~/data/shard

screen -d -m -S shard mongod --smallfiles --port 27017 --dbpath ~/data/shard

while ! nc -z localhost 27017; do   
  sleep 0.5 # wait for 1/10 of the second before check again
done

echo "mongodb shard is running"

# just for security.....
sleep 3