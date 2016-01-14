#!/bin/bash

export LC_ALL=C

mongo --port 27017 --eval  "sh.addShard( '`echo $shard_internal_nubomedia`:27017' )"

mongo --port 27017 --eval  'sh.enableSharding("nubomedia")'