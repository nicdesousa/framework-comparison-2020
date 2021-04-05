#!/bin/bash

java -jar "$1" &> /dev/null &
SERVER_PID=$!
while ! (node time.js "$1" &>/dev/null); do   
  sleep 0.1
done

CRPS=20
awkMemoryFmt='{ suffix="MGT"; for(i=0; $2>1024 && i < length(suffix); i++) $2/=1024; rss= int($2) substr(suffix, i, 1)"B, "; for(i=0; $3>1024 && i < length(suffix); i++) $3/=1024; vsz=int($3) substr(suffix, i, 1)"B"; print "RSS: " rss "VSZ: " vsz}'

echo "|- Running AB with ${CRPS} concurrent requests"
echo "|> Happy path"
echo "   $(ab -l -r -q -k -c ${CRPS} -n 10000 http://127.0.0.1:8080/hello/John | grep 'Requests per second')"
echo "   Java process memory:    $(ps -x -p "${SERVER_PID}" -o pid,rss,vsz,command | grep "^${SERVER_PID}" | awk "$awkMemoryFmt" )"
echo "|> Validation error path"
echo "   $(ab -l -r -q -k -c ${CRPS} -n 10000 http://127.0.0.1:8080/hello | grep 'Requests per second')"
echo "   Java process memory:    $(ps -x -p "${SERVER_PID}" -o pid,rss,vsz,command | grep "^${SERVER_PID}" | awk "$awkMemoryFmt" )"
kill -9 "${SERVER_PID}" &> /dev/null
