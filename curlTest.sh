#!/bin/bash
java -Xmx500m -Xms500m -jar "$1" &>/dev/null &
SERVER_PID=$!
while ! (node time.js "$1" &>/dev/null); do
  sleep 0.1
done

function callCurl() {
  curl -o /dev/null -s -w "Connect(%{time_connect}) + Transfer(%{time_starttransfer}) = %{time_total} s\n" "$1"
}

echo "|> Happy path"
echo "   $(callCurl http://127.0.0.1:8080/hello/John)"
echo "|> Validation error path"
echo "   $(callCurl http://127.0.0.1:8080/hello)"
kill -9 "${SERVER_PID}" &>/dev/null
