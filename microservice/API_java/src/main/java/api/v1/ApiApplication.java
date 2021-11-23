package api.v1;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.util.Collections;

@SpringBootApplication
//@ComponentScan(basePackages="com.nomad.dubbed")
public class ApiApplication {
    public static void main(String[] args) {
        SpringApplication app = new SpringApplication(ApiApplication.class);
        app.setDefaultProperties(Collections
                .singletonMap("server.port", "8083"));
        app.run(args);
    }
}

