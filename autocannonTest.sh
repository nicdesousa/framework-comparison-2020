#!/bin/bash

function getJsonVal { 
    python -c "import json,sys;sys.stdout.write(json.dumps(json.load(sys.stdin)$1))"; 
}

java -jar "$1" &> /dev/null &
SERVER_PID=$!
while ! (node time.js "$1" &>/dev/null); do   
  sleep 0.1
done

THREADS=$(getconf _NPROCESSORS_ONLN)
awkMemoryFmt='{ suffix="MGT"; for(i=0; $2>1024 && i < length(suffix); i++) $2/=1024; rss= int($2) substr(suffix, i, 1)"B, "; for(i=0; $3>1024 && i < length(suffix); i++) $3/=1024; vsz=int($3) substr(suffix, i, 1)"B"; print "RSS: " rss "VSZ: " vsz}'

echo "|- Running AutoCannon with ${THREADS} worker threads and 20 connections"
echo "|> Happy path"
RPS=$( autocannon --json -n -w ${THREADS} -c 20 http://127.0.0.1:8080/hello/John | getJsonVal "['requests']['mean']" | LC_ALL=en_US.UTF-8 awk '{ printf("%'"'"'d\n", int($0)) }' )
echo "   Requests/sec:        $RPS [#/sec] (mean)"
echo "   Java process memory: $(ps -x -p "${SERVER_PID}" -o pid,rss,vsz,command | grep "^${SERVER_PID}" | awk "$awkMemoryFmt" )"
echo "|> Validation error path"
RPS=$( autocannon --json -n -w ${THREADS} -c 20 http://127.0.0.1:8080/hello | getJsonVal "['requests']['mean']" | LC_ALL=en_US.UTF-8 awk '{ printf("%'"'"'d\n", int($0)) }' ) 
echo "   Requests/sec:        $RPS [#/sec] (mean)"
echo "   Java process memory: $(ps -x -p "${SERVER_PID}" -o pid,rss,vsz,command | grep "^${SERVER_PID}" | awk "$awkMemoryFmt" )"
kill -9 "${SERVER_PID}" &> /dev/null
