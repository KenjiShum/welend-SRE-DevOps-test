#!/bin/bash

logfile="docker_stats.log"

while true
do
    timestamp=$(date "+%Y.%m.%d-%H.%M.%S")
    echo "$timestamp" >> $logfile
    docker stats --no-stream >> $logfile
    echo "" >> $logfile
    sleep 10
done