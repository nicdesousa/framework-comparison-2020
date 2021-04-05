#!/bin/bash
source .bash_colors
clr_bold clr_white "==== ApacheBench Tests ===="

clr_bold clr_green "Micronaut"
./abTest.sh micronaut-example/target/micronaut-example-0.1.jar

clr_bold clr_green "Quarkus"
./abTest.sh quarkus-example/target/quarkus-app/quarkus-run.jar

clr_bold clr_green "Spring"
./abTest.sh spring-example/target/demo-0.0.1-SNAPSHOT.jar
