#!/bin/bash
source .bash_colors
clr_bold clr_white "==== NodeJS request Tests ===="

clr_bold clr_green "Micronaut"
node time.js micronaut-example/target/micronaut-example-0.1.jar

clr_bold clr_green "Quarkus"
node time.js quarkus-example/target/quarkus-app/quarkus-run.jar

clr_bold clr_green "Spring"
node time.js spring-example/target/demo-0.0.1-SNAPSHOT.jar
