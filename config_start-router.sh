#!/bin/bash

# mongo_config is not started yet...when ems will be solved then this can be removed.
sleep 30

export LC_ALL=C

screen -d -m -S router mongos --configdb $config_internal_nubomedia

while ! nc -z localhost 27017; do   
  sleep 0.5 # wait for 1/10 of the second before check again
done

echo "mongodb router is running"

# just for security.....
sleep 3