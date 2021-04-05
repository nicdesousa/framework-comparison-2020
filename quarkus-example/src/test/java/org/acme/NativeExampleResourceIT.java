package org.acme;

import io.quarkus.test.junit.NativeImageTest;
import org.junit.jupiter.api.Disabled;

@NativeImageTest
@Disabled   
public class NativeExampleResourceIT extends MessageResourceTest {

    // Execute the same tests but in native mode.
}