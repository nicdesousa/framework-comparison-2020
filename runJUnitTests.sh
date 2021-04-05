#!/bin/bash
source .bash_colors
clr_bold clr_white "==== JUnit Tests ===="

clr_bold clr_green "Micronaut - RxHttpClient"
(
  cd micronaut-example
  ./mvnw test -Dtest=micronaut.example.MessageControllerTest
)  | grep 'Total time'
  
clr_bold clr_green "Micronaut - Rest-Assured"
(
  cd micronaut-example
  ./mvnw test -Dtest=micronaut.example.MessageControllerRestAssuredTest
) | grep 'Total time'

clr_bold clr_green "Quarkus"
(
  cd quarkus-example
  ./mvnw test
)  | grep 'Total time'

clr_bold clr_green "Spring"
(
  cd spring-example
  ./mvnw test
)  | grep 'Total time'
