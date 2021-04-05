#!/bin/bash

function fail() {
    echo " -> Failed!"
    exit 1
}

echo "Building micronaut-example..."
(
  cd micronaut-example
  ./mvnw clean package
) >/dev/null || fail
  
echo "Building quarkus-example..."
(
  cd quarkus-example
  ./mvnw clean package
) >/dev/null || fail
  
echo "Building spring-example..."
(
  cd spring-example
  ./mvnw clean package
) >/dev/null || fail

echo "Configuring NodeJS [request] module..."
(
  npm list request || npm install request &>/dev/null
) >/dev/null || fail

echo "Configuring NodeJS [autocannon] module..."
(
  npm list autocannon || npm i autocannon -g &>/dev/null
) >/dev/null || fail