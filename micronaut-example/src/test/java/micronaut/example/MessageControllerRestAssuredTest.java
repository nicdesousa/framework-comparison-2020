package micronaut.example;

import io.micronaut.test.annotation.MicronautTest;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.condition.EnabledIfEnvironmentVariable;
import org.junit.jupiter.api.condition.EnabledIfSystemProperty;

import static io.restassured.RestAssured.given;
import static org.hamcrest.CoreMatchers.is;

@MicronautTest
public class MessageControllerRestAssuredTest {

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
