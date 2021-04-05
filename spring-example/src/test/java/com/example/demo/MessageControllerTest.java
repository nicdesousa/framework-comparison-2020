package com.example.demo;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import static io.restassured.RestAssured.given;
import static org.hamcrest.CoreMatchers.is;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.DEFINED_PORT)
class MessageControllerTest {
	
    @Test
    void testMessage() {
        given()
                .port(8080)
                .when().get("/hello/John")
                .then()
                .statusCode(200)
                .body(is("Hello John"));
    }

}
